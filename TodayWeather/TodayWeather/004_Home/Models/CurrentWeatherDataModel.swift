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
struct CurrentWeatherDataModelElement: Codable {
    var obTime: String?
    var dni: Int?
    var windCdirFull: String?
    var precip: Int?
    var datetime, windCdir: String?
    var elevAngle: Double?
    var vis: Int?
    var stateCode: String?
    var hAngle, ghi: Int?
    var slp: Double?
    var weather: Weather?
    var timezone, lastObTime, station: String?
    var ts, snow: Int?
    var pod, countryCode: String?
    var rh: Int?
    var appTemp, windSpd: Double?
    var cityName, sunset: String?
    var temp: Double?
    var sunrise: String?
    var dewpt: Double?
    var clouds, windDir, solarRAD, aqi: Int?
    var dhi: Int?
    var lon, lat: Double?
    var uv: Int?
    var pres: Double?

    enum CodingKeys: String, CodingKey {
        case obTime = "ob_time"
        case dni
        case windCdirFull = "wind_cdir_full"
        case precip, datetime
        case windCdir = "wind_cdir"
        case elevAngle = "elev_angle"
        case vis
        case stateCode = "state_code"
        case hAngle = "h_angle"
        case ghi, slp, weather, timezone
        case lastObTime = "last_ob_time"
        case station, ts, snow, pod
        case countryCode = "country_code"
        case rh
        case appTemp = "app_temp"
        case windSpd = "wind_spd"
        case cityName = "city_name"
        case sunset, temp, sunrise, dewpt, clouds
        case windDir = "wind_dir"
        case solarRAD = "solar_rad"
        case aqi, dhi, lon, lat, uv, pres
    }
}

// MARK: CurrentWeatherDataModelElement convenience initializers and mutators

extension CurrentWeatherDataModelElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CurrentWeatherDataModelElement.self, from: data)
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
        obTime: String?? = nil,
        dni: Int?? = nil,
        windCdirFull: String?? = nil,
        precip: Int?? = nil,
        datetime: String?? = nil,
        windCdir: String?? = nil,
        elevAngle: Double?? = nil,
        vis: Int?? = nil,
        stateCode: String?? = nil,
        hAngle: Int?? = nil,
        ghi: Int?? = nil,
        slp: Double?? = nil,
        weather: Weather?? = nil,
        timezone: String?? = nil,
        lastObTime: String?? = nil,
        station: String?? = nil,
        ts: Int?? = nil,
        snow: Int?? = nil,
        pod: String?? = nil,
        countryCode: String?? = nil,
        rh: Int?? = nil,
        appTemp: Double?? = nil,
        windSpd: Double?? = nil,
        cityName: String?? = nil,
        sunset: String?? = nil,
        temp: Double?? = nil,
        sunrise: String?? = nil,
        dewpt: Double?? = nil,
        clouds: Int?? = nil,
        windDir: Int?? = nil,
        solarRAD: Int?? = nil,
        aqi: Int?? = nil,
        dhi: Int?? = nil,
        lon: Double?? = nil,
        lat: Double?? = nil,
        uv: Int?? = nil,
        pres: Double?? = nil
    ) -> CurrentWeatherDataModelElement {
        return CurrentWeatherDataModelElement(
            obTime: obTime ?? self.obTime,
            dni: dni ?? self.dni,
            windCdirFull: windCdirFull ?? self.windCdirFull,
            precip: precip ?? self.precip,
            datetime: datetime ?? self.datetime,
            windCdir: windCdir ?? self.windCdir,
            elevAngle: elevAngle ?? self.elevAngle,
            vis: vis ?? self.vis,
            stateCode: stateCode ?? self.stateCode,
            hAngle: hAngle ?? self.hAngle,
            ghi: ghi ?? self.ghi,
            slp: slp ?? self.slp,
            weather: weather ?? self.weather,
            timezone: timezone ?? self.timezone,
            lastObTime: lastObTime ?? self.lastObTime,
            station: station ?? self.station,
            ts: ts ?? self.ts,
            snow: snow ?? self.snow,
            pod: pod ?? self.pod,
            countryCode: countryCode ?? self.countryCode,
            rh: rh ?? self.rh,
            appTemp: appTemp ?? self.appTemp,
            windSpd: windSpd ?? self.windSpd,
            cityName: cityName ?? self.cityName,
            sunset: sunset ?? self.sunset,
            temp: temp ?? self.temp,
            sunrise: sunrise ?? self.sunrise,
            dewpt: dewpt ?? self.dewpt,
            clouds: clouds ?? self.clouds,
            windDir: windDir ?? self.windDir,
            solarRAD: solarRAD ?? self.solarRAD,
            aqi: aqi ?? self.aqi,
            dhi: dhi ?? self.dhi,
            lon: lon ?? self.lon,
            lat: lat ?? self.lat,
            uv: uv ?? self.uv,
            pres: pres ?? self.pres
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Weather
struct Weather: Codable {
    var icon, code, weatherDescription: String?

    enum CodingKeys: String, CodingKey {
        case icon, code
        case weatherDescription = "description"
    }
}

// MARK: Weather convenience initializers and mutators

extension Weather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weather.self, from: data)
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
        icon: String?? = nil,
        code: String?? = nil,
        weatherDescription: String?? = nil
    ) -> Weather {
        return Weather(
            icon: icon ?? self.icon,
            code: code ?? self.code,
            weatherDescription: weatherDescription ?? self.weatherDescription
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias CurrentWeatherDataModel = [CurrentWeatherDataModelElement]

extension Array where Element == CurrentWeatherDataModel.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CurrentWeatherDataModel.self, from: data)
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

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
