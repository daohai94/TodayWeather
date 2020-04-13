//
//  DailyWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

// MARK: - DailyWeatherDataModel
struct DailyWeatherDataModel {
    var validDate: String?
    var ts: Int?
    var datetime: String?
    var windGustSpd, windSpd: Double?
    var windDir: Int?
    var windCdir, windCdirFull: String?
    var temp, maxTemp, minTemp, highTemp: Int?
    var lowTemp, appMaxTemp, appMinTemp: Double?
    var pop, precip, snow, snowDepth: Int?
    var slp: Int?
    var pres, dewpt, rh: Double?
    var weatherIcon: WeatherIcon?
    var pod: String?
    var cloudsLow, cloudsMid, cloudsHi, clouds: Int?
    var vis, maxDhi, uv: Int?
    var moonPhase, moonPhaseLunation: Double?
    var moonriseTs, moonsetTs, sunriseTs, sunsetTs: Int?
}
