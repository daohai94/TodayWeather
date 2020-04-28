//
//  WeatherCollectionViewCell.swift
//  TodayWeather
//
//  Created by Tuan Vu on 4/12/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import UICircularProgressRing
class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sunSetView: UIView!

    let progressRing = UICircularTimerRing()
    override func awakeFromNib() {
        super.awakeFromNib()

//        progressRing.maxValue = 100
//        progressRing.value = 30
        progressRing.style = .dashed(pattern: [7.0, 7.0])
        
        progressRing.backgroundColor = .red
        sunSetView.addSubview(progressRing)

        progressRing.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: progressRing, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sunSetView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: progressRing, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sunSetView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let traillingConstraint = NSLayoutConstraint(item: progressRing, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sunSetView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: progressRing, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sunSetView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        sunSetView.addConstraints([leadingConstraint, topConstraint, traillingConstraint, bottomConstraint])


        slider.setThumbImage(UIImage(named: "dot"), for: .normal)
        slider.setThumbImage(UIImage(named: "dot"), for: .highlighted)
    }

}
