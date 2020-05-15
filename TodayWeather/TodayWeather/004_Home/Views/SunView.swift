//
//  SunView.swift
//  TodayWeather
//
//  Created by Nguyễn Tuấn Vũ on 5/14/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class SunView: UIView {
    var layerColor: UIColor = UIColor(hexString: "F5CA68")
    var lineButtomColor: UIColor = UIColor(hexString: "1B1B1B")
    var mainColor: UIColor = UIColor(hexString: "F5CA68")
    var margin: CGFloat = 48
    var numberDot: Int = 30
    
    var stringFrom: String = "" {
        didSet {
            removeStringFrom()
            drawStringFrom()
        }
    }
    
    var stringTo: String = "" {
        didSet {
            removeStringTo()
            drawStringTo()
        }
    }
    
    var percent: CGFloat = 0 {
        didSet {
            removeLineBottom()
            removeDotFromTo()
            removeLayer()
            drawLineBottom()
            drawLayer()
            drawDotFromTo()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        removeLayer()
        removeDotFromTo()
        removeStringTo()
        removeStringFrom()
        removeLineBottom()
        
        drawLayer()
        drawLineBottom()
        drawStringTo()
        drawStringFrom()
        drawDotFromTo()
        
    }
    
    let pixel: CGFloat = 1 / UIScreen.main.scale
    let heightFooter: CGFloat = 40
    
    func drawLayer(fromTitle: String, toTitle: String, percent: CGFloat) {
        self.stringFrom = fromTitle
        self.stringTo = toTitle
        self.percent = percent
    }
    
    private func drawLineBottom() {
        let fr = self.frame
        let line = UIView(frame: CGRect(x: 0, y: fr.size.height-pixel-heightFooter, width: fr.size.width, height: pixel) )
        line.backgroundColor = lineButtomColor
        line.tag = 5
        addSubview(line)
    }
    
    private func drawStringFrom() {
        let fromLabel = UILabel(frame: CGRect(origin: CGPoint(x: margin, y: frame.height-heightFooter/2), size: CGSize(width: 150, height: heightFooter)))
        fromLabel.center = CGPoint(x: margin, y: frame.height-heightFooter/2)
        fromLabel.textColor = mainColor
        fromLabel.text = stringFrom
        fromLabel.textAlignment = .center
        fromLabel.tag = 1
        addSubview(fromLabel)
    }
    
    private func drawStringTo() {
        let toLabel = UILabel(frame: CGRect(origin: CGPoint(x: frame.width-margin, y: frame.height-heightFooter/2), size: CGSize(width: 150, height: heightFooter)))
        toLabel.center = CGPoint(x: frame.width-margin, y: frame.height-heightFooter/2)
        toLabel.textColor = mainColor
        toLabel.text = stringTo
        toLabel.textAlignment = .center
        toLabel.tag = 2
        addSubview(toLabel)
    }
    
    private func drawDotFromTo() {
        let fromDot = UIView(frame: CGRect(origin: CGPoint(x: margin-4, y: frame.height-heightFooter-4), size: CGSize(width: 8, height: 8)))
        let toDot = UIView(frame: CGRect(origin: CGPoint(x: frame.width-margin-4, y: frame.height-heightFooter-4), size: CGSize(width: 8, height: 8)))
        fromDot.backgroundColor = mainColor
        fromDot.tag = 4
        fromDot.layer.cornerRadius = 4
        fromDot.clipsToBounds = true
        toDot.backgroundColor = mainColor
        toDot.tag = 4
        toDot.layer.cornerRadius = 4
        toDot.clipsToBounds = true
        addSubview(toDot)
        addSubview(fromDot)
    }
    
    //    private func drawLayer() {
    //        let radius = (frame.width-2*margin)/2
    //        for index in (0...Int(frame.width-2*margin)) {
    //            var value = 2*CGFloat(index)*radius
    //            value -= CGFloat(index*index)
    //            let yValue = value.squareRoot()
    //            let dotView = UIView(frame: CGRect(origin: CGPoint(x: margin + CGFloat(index), y: frame.height - heightFooter - yValue), size: CGSize(width: pixel, height: 2)))
    //            dotView.backgroundColor = lineButtomColor
    //            addSubview(dotView)
    //        }
    //    }
    
    private func drawLayer() {
        let percen = percent > 1 ? 1 : percent
        let radius = (frame.width-2*margin)/2
        var color: UIColor = UIColor.gray
        var isDrawSun = false
        for index in (0...numberDot) {
            var willcheck = false
            if CGFloat(index)/CGFloat(numberDot) >= percen {
                color = lineButtomColor
                willcheck = true
            } else {
                color = mainColor
            }
            var point = CGPoint()
            let alpha = Double(index) / Double(numberDot) * Double.pi
            if alpha > Double.pi/2 {
                let newAlpha = Double.pi - alpha
                point = CGPoint(x: radius + CGFloat(cos(newAlpha))*radius, y: CGFloat(sin(newAlpha))*radius)
            } else {
                point = CGPoint(x: radius - CGFloat(cos(alpha))*radius, y: CGFloat(sin(alpha))*radius)
            }
            
            let dotView = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 6))
            dotView.backgroundColor = color
            dotView.center = CGPoint(x: margin + point.x, y: frame.height - heightFooter - point.y)
            dotView.transform = CGAffineTransform(rotationAngle: CGFloat(alpha))
            dotView.layer.cornerRadius = 0.5
            dotView.clipsToBounds = true
            dotView.tag = 3
            addSubview(dotView)
            if willcheck && !isDrawSun {
                let sunView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
                sunView.image = UIImage(named: "sun")
                sunView.center = CGPoint(x: margin + point.x, y: frame.height - heightFooter - point.y)
                sunView.tag = 3
                addSubview(sunView)
                sunView.layer.zPosition = 1000
                isDrawSun = true
            }
        }
    }
    
    private func removeLayer() {
        for view in subviews {
            if view.tag == 3 {
                view.removeFromSuperview()
            }
        }
    }
    
    private func removeStringFrom() {
        for view in subviews {
            if view.tag == 1 {
                view.removeFromSuperview()
            }
        }
    }
    
    private func removeStringTo() {
        for view in subviews {
            if view.tag == 2 {
                view.removeFromSuperview()
            }
        }
    }
    
    private func removeDotFromTo() {
        for view in subviews {
            if view.tag == 4 {
                view.removeFromSuperview()
            }
        }
    }
    
    private func removeLineBottom() {
        for view in subviews {
            if view.tag == 5 {
                view.removeFromSuperview()
            }
        }
    }
}
