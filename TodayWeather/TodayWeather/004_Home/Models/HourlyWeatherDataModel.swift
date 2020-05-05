//
//  HourlyWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - HourlyWeatherDataModelElement
struct HourlyWeatherDataModelElement {
    var timestampLocal, timestampUTC: String?
    var ts: Int?
    var datetime: String?
    var windGustSpd, windSpd: Double?
    var windDir: Int?
    var windCdir, windCdirFull: String?
    var temp, appTemp, pop, precip: Int?
    var snow, snowDepth, slp: Int?
    var pres, dewpt, rh: Double?
    var weather: Weather?
    var pod: String?
    var cloudsLow, cloudsMid, cloudsHi, clouds: Int?
    var vis, dhi, dni, ghi: Int?
    var solarRAD: Double?
    var uv: Int?
    var ozone: Double?
}
extension HourlyWeatherDataModelElement {
    init(json:JSON) {
        self.timestampLocal = json["timestamp_local"].string
        self.timestampUTC = json["timestamp_utc"].string
        self.ts = json["ts"].int
        self.datetime = json["datetime"].string
        self.windGustSpd = json["wind_gust_spd"].double
        self.windSpd = json["wind_spd"].double
        self.windDir = json["wind_dir"].int
        self.windCdir = json["wind_cdir"].string
        self.windCdirFull = json["wind_cdir_full"].string
        self.temp = json["temp"].int
        self.appTemp = json["app_temp"].int
        self.pop = json["pop"].int
        self.precip = json["precip"].int
        self.snow = json["snow"].int
        self.snowDepth = json["snow_depth"].int
        self.slp = json["slp"].int
        self.pres = json["pres"].double
        self.dewpt = json["dewpt"].double
        self.rh = json["rh"].double
        self.weather = Weather(json: json["weather"])
        self.pod = json["pod"].string
        self.cloudsLow = json["clouds_low"].int
        self.cloudsMid = json["clouds_mid"].int
        self.cloudsHi = json["clouds_hi"].int
        self.clouds = json["clouds"].int
        self.vis = json["vis"].int
        self.dhi = json["dhi"].int
        self.dni = json["dni"].int
        self.ghi = json["ghi"].int
        self.solarRAD = json["solar_rad"].double
        self.uv = json["uv"].int
        self.ozone = json["ozone"].double
    }
}

