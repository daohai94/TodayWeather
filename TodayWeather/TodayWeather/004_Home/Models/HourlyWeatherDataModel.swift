//
//  HourlyWeatherDataModel.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/13/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

// MARK: - HourlyWeatherDataModelElement
struct HourlyWeatherDataModelElement: Codable {
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

    enum CodingKeys: String, CodingKey {
        case timestampLocal = "timestamp_local"
        case timestampUTC = "timestamp_utc"
        case ts, datetime
        case windGustSpd = "wind_gust_spd"
        case windSpd = "wind_spd"
        case windDir = "wind_dir"
        case windCdir = "wind_cdir"
        case windCdirFull = "wind_cdir_full"
        case temp
        case appTemp = "app_temp"
        case pop, precip, snow
        case snowDepth = "snow_depth"
        case slp, pres, dewpt, rh, weather, pod
        case cloudsLow = "clouds_low"
        case cloudsMid = "clouds_mid"
        case cloudsHi = "clouds_hi"
        case clouds, vis, dhi, dni, ghi
        case solarRAD = "solar_rad"
        case uv, ozone
    }
}

// MARK: HourlyWeatherDataModelElement convenience initializers and mutators

extension HourlyWeatherDataModelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HourlyWeatherDataModelElement.self, from: data)
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
        timestampLocal: String?? = nil,
        timestampUTC: String?? = nil,
        ts: Int?? = nil,
        datetime: String?? = nil,
        windGustSpd: Double?? = nil,
        windSpd: Double?? = nil,
        windDir: Int?? = nil,
        windCdir: String?? = nil,
        windCdirFull: String?? = nil,
        temp: Int?? = nil,
        appTemp: Int?? = nil,
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
        dhi: Int?? = nil,
        dni: Int?? = nil,
        ghi: Int?? = nil,
        solarRAD: Double?? = nil,
        uv: Int?? = nil,
        ozone: Double?? = nil
    ) -> HourlyWeatherDataModelElement {
        return HourlyWeatherDataModelElement(
            timestampLocal: timestampLocal ?? self.timestampLocal,
            timestampUTC: timestampUTC ?? self.timestampUTC,
            ts: ts ?? self.ts,
            datetime: datetime ?? self.datetime,
            windGustSpd: windGustSpd ?? self.windGustSpd,
            windSpd: windSpd ?? self.windSpd,
            windDir: windDir ?? self.windDir,
            windCdir: windCdir ?? self.windCdir,
            windCdirFull: windCdirFull ?? self.windCdirFull,
            temp: temp ?? self.temp,
            appTemp: appTemp ?? self.appTemp,
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
            dhi: dhi ?? self.dhi,
            dni: dni ?? self.dni,
            ghi: ghi ?? self.ghi,
            solarRAD: solarRAD ?? self.solarRAD,
            uv: uv ?? self.uv,
            ozone: ozone ?? self.ozone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias HourlyWeatherDataModel = [HourlyWeatherDataModelElement]

extension Array where Element == HourlyWeatherDataModel.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HourlyWeatherDataModel.self, from: data)
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

