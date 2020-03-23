//
//  UserSettingManager.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation
import RealmSwift

class UserSettingManager {
    var realm:Realm
    static let shared = UserSettingManager()
    private init() {
        realm = try! Realm()
    }
    
    func getUserSetting() -> UserSetting{
        var userSetting:UserSetting?
        if let setting = realm.objects(UserSetting.self).first {
            userSetting = setting
        }else {
            userSetting = UserSetting()
            userSetting?.id.value = 1
            userSetting?.isEnabledPicture = true
            userSetting?.iconSetIndex.value = 1
            userSetting?.temperatureUnit = TemperatureUnit.C.rawValue
            userSetting?.distanceInit = DistanceUnit.km.rawValue
            userSetting?.speedUnit = SpeedUnit.kmh.rawValue
            userSetting?.pressureUnit = PressureUnit.mBar.rawValue
            userSetting?.isEnabledDailyNotification = true
            userSetting?.timeNotification = "08:00".String2Date(format: "HH:mm")
            userSetting?.isEnabledSevereAlert = true
            userSetting?.isEnabledRainSnowAlarm = true
            userSetting?.dataSource = DataSource.weatherbit.rawValue
            userSetting?.userName = nil
            userSetting?.language = Language.english.rawValue
            userSetting?.currentLocation = nil
            try! realm.write {
                realm.add(userSetting!)
            }
        }
        
        return userSetting!
    }
    
    func updateUserSetting(userSetting:UserSetting) {
        try! realm.write{
            realm.add(userSetting, update: .modified)
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
