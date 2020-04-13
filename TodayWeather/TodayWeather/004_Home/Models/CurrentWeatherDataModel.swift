//
//  CurrentWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

// MARK: - CurrentWeatherDataModel
struct CurrentWeatherDataModel {
    var windCdir: String?
    var rh: Int?
    var pod, lon: String?
    var pres: Double?
    var timezone, obTime, countryCode: String?
    var clouds, vis: Int?
    var windSpd: Double?
    var windCdirFull: String?
    var appTemp: Double?
    var stateCode: String?
    var ts, hAngle: Int?
    var dewpt: Double?
    var weatherIcon: WeatherIcon?
    var uv, aqi: Int?
    var station: String?
    var windDir, elevAngle: Int?
    var datetime: String?
    var precip: Int?
    var ghi: Double?
    var dni, dhi, solarRAD: Int?
    var cityName, sunrise, sunset: String?
    var temp: Double?
    var lat: String?
    var slp: Double?
}

// MARK: - Weather
struct WeatherIcon {
    var icon, code, weatherDescription: String?
}
