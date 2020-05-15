//
//  CurrentWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - CurrentWeatherDataModelElement
struct CurrentWeatherDataModelElement {
    var lastObTime, obTime: String?
    var temp: Double?
    var ghi: Double?
    var cityName: String?
    var windSpd, dhi: Double?
    var windCdir, sunrise, sunset: String?
    var slp: Int?
    var pod, countryCode: String?
    var precip, rh: Int?
    var lat: Double?
    var windDir: Int?
    var stateCode, station: String?
    var elevAngle: Double?
    var snow: Int?
    var dewpt, solarRAD: Double?
    var aqi: Int?
    var uv, hAngle: Double?
    var clouds: Int?
    var windCdirFull: String?
    var ts: Int?
    var appTemp: Double?
    var lon: Double?
    var timezone: String?
    var vis: Int?
    var dni: Double?
    var weather: Weather?
    var pres: Double?
    var datetime: String?
    
    func weatherDescription() -> String {
        return "Today - "
        + (self.weather?.weatherDescription ?? "")
        + ". High \(self.appTemp?.toTemp() ?? "")"
            + ", low \(self.dewpt?.toTemp() ?? ""). Wind \(self.windCdirFull ?? "") at \(Int(self.windSpd ?? 0)) \(AppManager.currentUserSetting?.speedUnit ?? "km/h")"
    }
}
extension CurrentWeatherDataModelElement {
    init(json:JSON) {
        self.lastObTime = json["last_ob_time"].string
        self.obTime = json["ob_time"].string
        self.temp = json["temp"].double
        self.ghi = json["ghi"].double
        self.cityName = json["city_name"].string
        self.windSpd = json["wind_spd"].double
        self.dhi = json["dhi"].double
        self.windCdir = json["wind_cdir"].string
        self.sunrise = json["sunrise"].string
        self.sunset = json["sunset"].string
        self.slp = json["slp"].int
        self.pod = json["pod"].string
        self.countryCode = json["country_code"].string
        self.precip = json["precip"].int
        self.rh = json["rh"].int
        self.lat = json["lat"].double
        self.windDir = json["wind_dir"].int
        self.stateCode = json["state_code"].string
        self.station = json["station"].string
        self.elevAngle = json["elev_angle"].double
        self.snow = json["snow"].int
        self.dewpt = json["dewpt"].double
        self.solarRAD = json["solar_rad"].double
        self.aqi = json["aqi"].int
        self.uv = json["uv"].double
        self.hAngle = json["h_angle"].double
        self.clouds = json["clouds"].int
        self.windCdirFull = json["wind_cdir_full"].string
        self.ts = json["ts"].int
        self.appTemp = json["app_temp"].double
        self.lon = json["lon"].double
        self.timezone = json["timezone"].string
        self.vis = json["vis"].int
        self.dni = json["dni"].double
        self.weather = Weather(json: json["weather"])
        self.pres = json["pres"].double
        self.datetime = json["datetime"].string
    }
}

// MARK: - Weather
struct Weather {
    var weatherDescription, icon, code: String?
    init(json:JSON) {
        self.weatherDescription = json["description"].string
        self.icon = json["icon"].string
        self.code = json["code"].string
    }
}

