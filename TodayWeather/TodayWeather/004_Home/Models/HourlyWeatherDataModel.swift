//
//  HourlyWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

// MARK: - HourlyWeatherDataModel
struct HourlyWeatherDataModel {
    var timestampLocal, timestampUTC: String?
    var ts: Int?
    var datetime: String?
    var windGustSpd, windSpd: Double?
    var windDir: Int?
    var windCdir, windCdirFull: String?
    var temp, appTemp, pop, precip: Int?
    var snow, snowDepth, slp: Int?
    var pres, dewpt, rh: Double?
    var weatherIcon: WeatherIcon?
    var pod: String?
    var cloudsLow, cloudsMid, cloudsHi, clouds: Int?
    var vis, dhi, dni, ghi: Int?
    var solarRAD: Double?
    var uv: Int?
    var ozone: Double?
}
