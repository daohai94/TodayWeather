//
//  DailyWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - DailyWeatherDataModelElement
struct DailyWeatherDataModelElement {
    var validDate: String?
    var ts: Int?
    var datetime: String?
    var windGustSpd, windSpd: Double?
    var windDir: Int?
    var windCdir, windCdirFull: String?
    var temp, maxTemp, minTemp, highTemp: Double?
    var lowTemp, appMaxTemp, appMinTemp: Double?
    var pop:Int?
    var precip: Double?
    var snow,snowDepth:Int?
    var slp: Double?
    var pres, dewpt: Double?
    var rh:Int?
    var weather: Weather?
    var pod: String?
    var cloudsLow, cloudsMid, cloudsHi, clouds: Int?
    var vis:Double?
    var maxDhi, uv: Double?
    var moonPhase:Double?
    var moonPhaseLunation: Double?
    var moonriseTs, moonsetTs, sunriseTs, sunsetTs: Int?
    
    func weatherDescription() -> String {
        return (self.weather?.weatherDescription ?? "")
        + ". High \(self.maxTemp?.toTemp() ?? "")"
        + ", low \(self.minTemp?.toTemp() ?? ""). Wind \(self.windCdirFull ?? "") at \(Int(self.windSpd ?? 0)) km/h"
    }
}

// MARK: DailyWeatherDataModelElement convenience initializers and mutators

extension DailyWeatherDataModelElement {
    init(json: JSON) {
        self.validDate = json["valid_date"].string
        self.ts = json["ts"].int
        self.datetime = json["datetime"].string
        self.windGustSpd = json["wind_gust_spd"].double
        self.windSpd = json["wind_spd"].double
        self.windDir = json["wind_dir"].int
        self.windCdir = json["wind_cdir"].string
        self.windCdirFull = json["wind_cdir_full"].string
        self.temp = json["temp"].double
        self.maxTemp = json["max_temp"].double
        self.minTemp = json["min_temp"].double
        self.highTemp = json["high_temp"].double
        self.lowTemp = json["low_temp"].double
        self.appMaxTemp = json["app_max_temp"].double
        self.appMinTemp = json["app_min_temp"].double
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
        self.maxDhi = json["max_dhi"].double
        self.uv = json["uv"].double
        self.moonPhase = json["moon_phase"].double
        self.moonPhaseLunation = json["moon_phase_lunation"].double
        self.moonriseTs = json["moonrise_ts"].int
        self.moonsetTs = json["moonset_ts"].int
        self.sunriseTs = json["sunrise_ts"].int
        self.sunsetTs = json["sunset_ts"].int
    }

    
}


