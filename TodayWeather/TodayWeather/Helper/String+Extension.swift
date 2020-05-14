//
//  String+Extension.swift
//  TodayWeather
//
//  Created by shjnbe on 5/5/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

extension Double {
    func toTempString() -> String {
        return "\(Int(self)) ° C"
    }
        
    func toTempNonSpaceString() -> String {
        return "\(Int(self))°C"
    }

    func toTemp() -> String {
        return "\(Int(self)) °"
    }
    func toString() -> String {
        return "\(Int(self))"
    }
}

extension Int {
    func toString() -> String {
        return "\(self)"
    }
}
