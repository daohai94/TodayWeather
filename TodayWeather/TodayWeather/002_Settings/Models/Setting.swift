//
//  Settings.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/19/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

struct Setting {
    var item:SettingItems
    var description:String
}

enum SettingItems : String {
    case picture = "Picture"
    case iconSet = "Icon Set"
    case unit = "Units"
    case notification = "Notification"
    case dataSource = "Data Source"
    case yourName = "Your Name"
    case language = "Language"
    case version = "Version"
}
