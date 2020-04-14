//
//  DailyWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

// MARK: - DailyWeatherDataModelElement
struct DailyWeatherDataModelElement: Codable {
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
    var weather: Weather?
    var pod: String?
    var cloudsLow, cloudsMid, cloudsHi, clouds: Int?
    var vis, maxDhi, uv: Int?
    var moonPhase, moonPhaseLunation: Double?
    var moonriseTs, moonsetTs, sunriseTs, sunsetTs: Int?

    enum CodingKeys: String, CodingKey {
        case validDate = "valid_date"
        case ts, datetime
        case windGustSpd = "wind_gust_spd"
        case windSpd = "wind_spd"
        case windDir = "wind_dir"
        case windCdir = "wind_cdir"
        case windCdirFull = "wind_cdir_full"
        case temp
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case appMaxTemp = "app_max_temp"
        case appMinTemp = "app_min_temp"
        case pop, precip, snow
        case snowDepth = "snow_depth"
        case slp, pres, dewpt, rh, weather, pod
        case cloudsLow = "clouds_low"
        case cloudsMid = "clouds_mid"
        case cloudsHi = "clouds_hi"
        case clouds, vis
        case maxDhi = "max_dhi"
        case uv
        case moonPhase = "moon_phase"
        case moonPhaseLunation = "moon_phase_lunation"
        case moonriseTs = "moonrise_ts"
        case moonsetTs = "moonset_ts"
        case sunriseTs = "sunrise_ts"
        case sunsetTs = "sunset_ts"
    }
}

// MARK: DailyWeatherDataModelElement convenience initializers and mutators

extension DailyWeatherDataModelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DailyWeatherDataModelElement.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        validDate: String?? = nil,
        ts: Int?? = nil,
        datetime: String?? = nil,
        windGustSpd: Double?? = nil,
        windSpd: Double?? = nil,
        windDir: Int?? = nil,
        windCdir: String?? = nil,
        windCdirFull: String?? = nil,
        temp: Int?? = nil,
        maxTemp: Int?? = nil,
        minTemp: Int?? = nil,
        highTemp: Int?? = nil,
        lowTemp: Double?? = nil,
        appMaxTemp: Double?? = nil,
        appMinTemp: Double?? = nil,
        pop: Int?? = nil,
        precip: Int?? = nil,
        snow: Int?? = nil,
        snowDepth: Int?? = nil,
        slp: Int?? = nil,
        pres: Double?? = nil,
        dewpt: Double?? = nil,
        rh: Double?? = nil,
        weather: Weather?? = nil,
        pod: String?? = nil,
        cloudsLow: Int?? = nil,
        cloudsMid: Int?? = nil,
        cloudsHi: Int?? = nil,
        clouds: Int?? = nil,
        vis: Int?? = nil,
        maxDhi: Int?? = nil,
        uv: Int?? = nil,
        moonPhase: Double?? = nil,
        moonPhaseLunation: Double?? = nil,
        moonriseTs: Int?? = nil,
        moonsetTs: Int?? = nil,
        sunriseTs: Int?? = nil,
        sunsetTs: Int?? = nil
    ) -> DailyWeatherDataModelElement {
        return DailyWeatherDataModelElement(
            validDate: validDate ?? self.validDate,
            ts: ts ?? self.ts,
            datetime: datetime ?? self.datetime,
            windGustSpd: windGustSpd ?? self.windGustSpd,
            windSpd: windSpd ?? self.windSpd,
            windDir: windDir ?? self.windDir,
            windCdir: windCdir ?? self.windCdir,
            windCdirFull: windCdirFull ?? self.windCdirFull,
            temp: temp ?? self.temp,
            maxTemp: maxTemp ?? self.maxTemp,
            minTemp: minTemp ?? self.minTemp,
            highTemp: highTemp ?? self.highTemp,
            lowTemp: lowTemp ?? self.lowTemp,
            appMaxTemp: appMaxTemp ?? self.appMaxTemp,
            appMinTemp: appMinTemp ?? self.appMinTemp,
            pop: pop ?? self.pop,
            precip: precip ?? self.precip,
            snow: snow ?? self.snow,
            snowDepth: snowDepth ?? self.snowDepth,
            slp: slp ?? self.slp,
            pres: pres ?? self.pres,
            dewpt: dewpt ?? self.dewpt,
            rh: rh ?? self.rh,
            weather: weather ?? self.weather,
            pod: pod ?? self.pod,
            cloudsLow: cloudsLow ?? self.cloudsLow,
            cloudsMid: cloudsMid ?? self.cloudsMid,
            cloudsHi: cloudsHi ?? self.cloudsHi,
            clouds: clouds ?? self.clouds,
            vis: vis ?? self.vis,
            maxDhi: maxDhi ?? self.maxDhi,
            uv: uv ?? self.uv,
            moonPhase: moonPhase ?? self.moonPhase,
            moonPhaseLunation: moonPhaseLunation ?? self.moonPhaseLunation,
            moonriseTs: moonriseTs ?? self.moonriseTs,
            moonsetTs: moonsetTs ?? self.moonsetTs,
            sunriseTs: sunriseTs ?? self.sunriseTs,
            sunsetTs: sunsetTs ?? self.sunsetTs
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias DailyWeatherDataModel = [DailyWeatherDataModelElement]

extension Array where Element == DailyWeatherDataModel.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DailyWeatherDataModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
