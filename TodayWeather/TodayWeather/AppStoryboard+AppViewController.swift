//
//  AppStoryboard.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/18/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation


enum AppStoryboard : String{
    case settings = "Settings"
    case menu = "Menu"
    case home = "Home"
    case splash = "Splash"
}

enum AppViewController : String {
    case settingsVC = "SettingsViewController"
    case menuVC = "MenuViewController"
    case homeVC = "HomeViewController"
    case iconSetSettingVC = "IconSetSettingViewController"
    case unitSettingVC = "UnitSettingViewController"
    case notificationSettingVC = "NotificationSettingViewController"
    case dataSourceSettingVC = "DataSourceSettingViewController"
    case languageSettingVC = "LanguageSettingViewController"
    case splashVC = "SplashViewController"
    case splashScene1VC = "SplashScene1ViewController"
    case splashScene2VC = "SplashScene2ViewController"
}
