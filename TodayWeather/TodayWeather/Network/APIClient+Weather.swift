//
//  APIClient+Weather.swift
//  TodayWeather
//
//  Created by Tuan Vu on 4/2/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension ApiClient {
    static func getAllEvents(success: @escaping ResponseSuccess,
                             fail: @escaping ResponseFailure) -> Request? {
        // create url
        let urlString = "v2.0/current"
        // create params
        var params = ApiClient.defaultParams()
        params["lat"] = 21.026685
        params["lon"] = 105.820765
        // create headers
        let headers = [HeaderKey.ContentType: HeaderValue.ApplicationJson]
        let url = ApiClient.weatherURL(urlString)
        return sessionManager.request(url, method: .get, parameters: params,
                                           encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                ApiClient.proccessResponse(success: success, fail: fail, response: response)
            }
    }
}
