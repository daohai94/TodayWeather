//
//  UserSetting.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

struct UserSetting {
    var id:Int64
    var isEnabledPicture:Bool
    var iconSetIndex:Int64
    var temperatureUnit:String
    var distanceInit:String
    var speedUnit:String
    var pressureUnit:String
    var isEnabledDailyNotification:Bool
    var timeNotification:Date
    var isEnabledSevereAlert:Bool
    var isEnabledRainSnowAlarm:Bool
    var dataSource:String
    var userName:String
    var language:String
}

enum TemperatureUnit : String {
    case C = "°C"
    case F = "°F"
}

enum DistanceUnit : String{
    case mi = "mi"
    case km = "km"
}

enum SpeedUnit : String{
    case mph = "mph"
    case kph = "kph"
    case kmh = "km/h"
    case ms = "m/s"
}

enum PressureUnit : String {
    case mBar = "mBar"
    case inHg = "inHg"
    case psi = "psi"
    case bar = "bar"
    case mmHg = "mmHg"
}

enum DataSource : String {
    case weatherbit = "Weatherbit.io"
}

enum Language : String {
    case vietnamese = "Vietnamese"
    case english = "English"
}
