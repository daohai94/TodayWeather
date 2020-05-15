//
//  AppManager.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

class AppManager {
    public static var currentUserSetting:UserSetting?
    public static var dailyNotificationIdentify = "daily_notification"
    public static var cities:[City] = []
    static var savedCities: [City] {
        get {
            if let decoded  = UserDefaults.standard.data(forKey: "Cities") {
                    let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [City]
                return decodedTeams ?? []
            }
            return []
        }
        
        set {
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(encodedData, forKey: "Cities")
            userDefaults.synchronize()
        }
    }
//    static var weatherData: [CurrentWeatherDataModelElement] = []
    static var weatherDayDatas: [WeatherDay] = []
}
