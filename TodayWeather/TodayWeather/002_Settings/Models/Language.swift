//
//  Language.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation

struct Language {
    var name:String
    var type:LanguageType
}

enum LanguageType {
    case defaultLanguage
    case vietnamese
    case english
}
