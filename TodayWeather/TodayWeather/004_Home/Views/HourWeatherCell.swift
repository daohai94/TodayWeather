//
//  HourWeatherCell.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class HourWeatherCell: UITableViewCell {

    @IBOutlet weak var imgWeatherStatus: UIImageView!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblRainPercent: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
