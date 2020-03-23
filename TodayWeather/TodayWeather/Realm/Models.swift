//
//  Models.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation
import RealmSwift

public class UserSetting: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var isEnabledPicture = true
    var iconSetIndex = RealmOptional<Int>()
    @objc dynamic var temperatureUnit:String? = nil
    @objc dynamic var distanceInit:String? = nil
    @objc dynamic var speedUnit:String? = nil
    @objc dynamic var pressureUnit:String? = nil
    @objc dynamic var isEnabledDailyNotification = true
    @objc dynamic var timeNotification:Date? = nil
    @objc dynamic var isEnabledSevereAlert = true
    @objc dynamic var isEnabledRainSnowAlarm = true
    @objc dynamic var dataSource:String? = nil
    @objc dynamic var userName:String? = nil
    @objc dynamic var language:String? = nil
    @objc dynamic var currentLocation:Location?
    public override class func primaryKey() -> String? {
        return "id"
    }
}


class Location: Object {
    var lat = RealmOptional<Float>()
    var long = RealmOptional<Float>()
    @objc dynamic var cityName:String? = nil
}






