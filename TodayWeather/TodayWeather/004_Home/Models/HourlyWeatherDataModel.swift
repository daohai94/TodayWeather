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
    var temp, appTemp, precip: Double?
    var pop:Int?
    var snow, snowDepth: Int?
    var slp:Double?
    var pres, dewpt: Double?
    var rh:Int?
    var weather: Weather?
    var pod: String?
    var cloudsLow, cloudsMid, cloudsHi, clouds: Int?
    var vis, dhi, dni, ghi: Double?
    var solarRAD: Double?
    var uv: Double?
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
        self.temp = json["temp"].double
        self.appTemp = json["app_temp"].double
        self.pop = json["pop"].int
        self.precip = json["precip"].double
        self.snow = json["snow"].int
        self.snowDepth = json["snow_depth"].int
        self.slp = json["slp"].double
        self.pres = json["pres"].double
        self.dewpt = json["dewpt"].double
        self.rh = json["rh"].int
        self.weather = Weather(json: json["weather"])
        self.pod = json["pod"].string
        self.cloudsLow = json["clouds_low"].int
        self.cloudsMid = json["clouds_mid"].int
        self.cloudsHi = json["clouds_hi"].int
        self.clouds = json["clouds"].int
        self.vis = json["vis"].double
        self.dhi = json["dhi"].double
        self.dni = json["dni"].double
        self.ghi = json["ghi"].double
        self.solarRAD = json["solar_rad"].double
        self.uv = json["uv"].double
        self.ozone = json["ozone"].double
    }
}

