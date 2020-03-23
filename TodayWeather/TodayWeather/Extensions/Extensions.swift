//
//  Extensions.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/18/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import Foundation
import UIKit

/* set color with hex string code */
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
}
@IBDesignable extension UIView {
    
    // tạo shadow cho view
    func addBottomBorder() {
        let bottomBorder: UIView = UIView()
        bottomBorder.backgroundColor = UIColor(
            red: CGFloat((0x1a1a1a & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((0x1a1a1a & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(0x1a1a1a & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        bottomBorder.frame = CGRect(x: 0, y: self.bounds.size.height - 1, width: UIScreen.main.bounds.size.width, height: 1);
        self.addSubview(bottomBorder)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        if #available(iOS 11.0, *) {
            
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            //not avalable in ios 11 <
            self.layer.masksToBounds = true
            self.layer.cornerRadius = radius
        }
    }
    
    func set(anchorPoint: CGPoint) {
        
        let originalPosition = CGPoint(x: frame.midX, y: frame.midY)
        
        let width = bounds.width
        let height = bounds.height
        
        let newXPosition = originalPosition.x +  (anchorPoint.x - 0.5) * width
        let newYPosition = originalPosition.y + (anchorPoint.y - 0.5) * height
        
        layer.anchorPoint = anchorPoint
        
        layer.position = CGPoint(x: newXPosition,
                                 y: newYPosition)
    }
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension Date {
    func Date2String(format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func String2Date(format:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)!
    }
}
