import Alamofire
import SwiftyJSON

let kKeyRefreshTokenUserDefault = "Authentication kKeyRefreshTokenUserDefault"
let kKeyRefreshTokenKeychain = "Authentication kKeyRefreshTokenKeychain"
let kKeyAccessToken = "Authentication kKeyAccessToken"

class OAuth2Handler: RequestAdapter, RequestRetrier {

    static let instance = OAuth2Handler()
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void

    private let authenSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders?["Accept"] = "application/json"
        configuration.timeoutIntervalForRequest = 60
        let session = SessionManager(configuration: configuration)
        return session
    }()

    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []

    // MARK: - Authentication info
    public var refreshToken: String? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: kKeyRefreshTokenUserDefault)
        }
        set(value) {
            let defaults = UserDefaults.standard
            defaults.setValue(value, forKey: kKeyRefreshTokenUserDefault)
        }
    }

    private var accessToken: String? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: kKeyAccessToken)
        }

        set(value) {
            let defaults = UserDefaults.standard
            defaults.setValue(value, forKey: kKeyAccessToken)
        }
    }

    // MARK: - Initialization
    public init() {
    }

    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let accessToken = self.accessToken {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: HeaderKey.Authorization)
        }
        return urlRequest
    }

    // MARK: - RequestRetrier
    func should(_ manager: SessionManager,
                retry request: Request,
                with error: Error,
                completion: @escaping RequestRetryCompletion) {
        lock.lock()
        defer { lock.unlock() }
        if  let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401 {
            self.requestsToRetry.append(completion)
            if !self.isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                    guard let strongSelf = self else { return }
                    strongSelf.lock.lock()
                    defer {
                        strongSelf.lock.unlock()
                    }
                    if let accessToken = accessToken, let refreshToken = refreshToken {
                        strongSelf.accessToken = accessToken
                        strongSelf.refreshToken = refreshToken
                        strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                        strongSelf.requestsToRetry.removeAll()
                        strongSelf.isRefreshing = false
                    }
                }
            }
        } else {
            completion(false, 0.0)
        }
    }

    // MARK: - Private - Refresh Tokens
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !self.isRefreshing, let refreshToken = self.refreshToken else { return }
        self.isRefreshing = true
        // create url
        let urlString = "api/v2/token/refresh"
        // create params
        var params = JSONDictionary()
        params["refresh_token"] = refreshToken
        // create headers
        let headers = [HeaderKey.ContentType: HeaderValue.ApplicationXWWWFormUrlencoded]
        let url = ApiClient.aclURL(urlString)
        // request
        authenSessionManager.request(url, method: .post, parameters: params,
                               encoding: URLEncoding.queryString, headers: headers)
            .responseJSON { [weak self]  response in
                guard self != nil else { return }
                // Failure response
                if response.result.isFailure {
                    completion(false, nil, nil)
                } else {
                    if let data = response.result.value {
                        let json = JSON(data)
                        if  let accessToken = json["token"].string,
                            let refreshToken = json["refresh_token"].string {
                            completion(true, accessToken, refreshToken)
                        } else if  let code = json["message"]["general"]["code"].string,
                            (code == "token_invalid_rule_error" || code == "token_expired_rule_error") {
                            completion(false, nil, nil)
                            AppDelegate.expiredSession()
                        } else {
                            completion(false, nil, nil)
                        }
                    } else {
                        completion(false, nil, nil)
                    }
                }
            }
    }

    func isAuthenticated() -> Bool {
        guard self.accessToken != nil && self.refreshToken != nil else { return false }
        return true
    }

    func authenticate(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

    func clear() {
        self.accessToken = nil
        self.refreshToken = nil
    }
}
