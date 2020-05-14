//
//  Date+Extension.swift
//  TodayWeather
//
//  Created by shjnbe on 5/5/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

extension DateFormatter {
    
    static func formatter(with format: String, localeIdentifier: String? = "en", timeZone: TimeZone? = TimeZone.current) -> DateFormatter {
        
        let formatter = DateFormatter()
        var locale: Locale
        var format = format
        
        if let localeIdentifier = localeIdentifier {
            locale = Locale(identifier: localeIdentifier)
            format = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: locale) ?? format
            formatter.locale = locale
        }
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        
        return formatter
    }
    
    static func date(from string: String, format: String, localeIdentifier: String? = nil, timeZone: TimeZone? = nil) -> Date? {
        
        let formatter = DateFormatter.formatter(
            with: format,
            localeIdentifier: localeIdentifier,
            timeZone: timeZone ?? TimeZone.current
        )
        
        return formatter.date(from: string)
    }
    
    static func string(from date: Date, format: String, localeIdentifier: String? = nil, timeZone: TimeZone? = nil) -> String {
        
        let formatter = DateFormatter.formatter(
            with: format,
            localeIdentifier: localeIdentifier,
            timeZone: timeZone
        )
        
        return formatter.string(from: date)
    }

}
