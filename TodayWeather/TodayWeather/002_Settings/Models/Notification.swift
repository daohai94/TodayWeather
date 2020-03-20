//
//  Notification.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

struct Notification {
    var name:NotificationName
    var description:String
}

enum NotificationName : String {
    case daily = "Daily Notification"
    case time = "Time"
    case severeAlert = "Severe Alert"
    case rainAndSnowAlarm = "Rain & Snow Alarm"
}
