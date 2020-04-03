import Alamofire
import SwiftyJSON

public typealias HttpResponse = (HTTPURLResponse, Any)
let sdErrorDomain = "HottabErrorDomain"

struct HeaderKey {
    static let ContentType              = "Content-Type"
    static let Authorization            = "Authorization"
    static let Token                    = "token"
}

struct HeaderValue {
    static let ApplicationJson                     = "application/json"
    static let ApplicationXWWWFormUrlencoded       = "application/x-www-form-urlencoded"
}
enum RequestResult {
    case success
    case error
    case errorCode
    case timeOut
    case noConnection
}

public struct ResponseObject {
    let data: AnyObject?
    let code: Int? // code error, incase success
    let result: RequestResult
}

public typealias JSONDictionary = [String: Any]
typealias ResponseSuccess = (_ response: AnyObject) -> Void
typealias ResponseFailure = (_ errorCode: Int, _ data: JSON?) -> Void

// MARK: - Class
class ApiClient: NSObject {

//    static let oauthHandler = OAuth2Handler()
    static let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders?["Accept"] = "application/json"
        configuration.timeoutIntervalForRequest = 40
        let session = SessionManager(configuration: configuration)
//        let oauthConnectHandler = OAuth2Handler.instance
//        session.adapter = oauthConnectHandler
//        session.retrier = oauthConnectHandler
        return session
    }()

    static let sessionWithoutToken: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders?["Accept"] = "application/json"
        configuration.timeoutIntervalForRequest = 20
        let session = SessionManager(configuration: configuration)
        return session
    }()

    // MARK: - Defaults
    static func weatherURL(_ urlString: String) -> String {
        return Configs.baseURL + urlString
    }

    static func defaultParams(countryCode: String? = nil) -> JSONDictionary {
        var params = JSONDictionary()
        params["key"] = Configs.apiKey
        params["language"] = "en"
        return params
    }

    // MARK: - Functions
    static func analyzeResponse(response: DataResponse<Any>, completionHandler: ((ResponseObject) -> Void)?) {

        // http code
        var httpCode = 0
        if let resp = response.response {
            httpCode = resp.statusCode
        }
        // success
        if let value = response.result.value {
            ApiClient.successWithValue(value: value, httpCode: httpCode, completionHandler: completionHandler)
        } else { // failure
            ApiClient.failureWithError(httpCode: httpCode, completionHandler: completionHandler)
        }
    }

    static func successWithValue(value: Any, httpCode: Int, completionHandler: ((ResponseObject) -> Void)?) {
        //Log.debug(message: "JSON : \(value)")
        // if ok
        if httpCode == 0 || httpCode == 200 {
            // create obj response
            let responseObject = ResponseObject(data: value as AnyObject, code: httpCode, result: .success)

            // block
            completionHandler?(responseObject)
            return
        }

        //Log.debug(message: "Code  error : \(String(describing: httpCode))")

        // create obj response
        let responseObject = ResponseObject(data: nil, code: httpCode, result: .errorCode)

        // block
        completionHandler?(responseObject)

    }

    static func failureWithError(httpCode: Int, completionHandler: ((ResponseObject) -> Void)?) {
        // create obj response
        let responseObject = ResponseObject(data: nil, code: httpCode, result: .error)
        // block
        completionHandler?(responseObject)
    }

    static func proccessResponse(success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFailure,
                                 response: DataResponse<Any>) {
        if response.result.isFailure {
            if let statusCode = response.response?.statusCode, let responseData = response.data {
                fail(statusCode, JSON(responseData))
            } else {
                fail(-1, nil)
            }
        } else if let value = response.result.value {
            success(value as AnyObject)
        }
    }

}
