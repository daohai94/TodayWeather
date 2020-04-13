//
//  WeatherCollectionViewCell.swift
//  TodayWeather
//
//  Created by Tuan Vu on 4/12/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var slider: UISlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        slider.setThumbImage(UIImage(named: "dot"), for: .normal)
        slider.setThumbImage(UIImage(named: "dot"), for: .highlighted)
    }

}
