//
//  DayWeatherCell.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {

    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var imgWeatherStatus: UIImageView!
    @IBOutlet weak var lblRainPercent: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ day: DailyWeatherDataModelElement) {
        lblDay.text = DateFormatter.string(from: day.ts ?? 0, format: DateFormat.EEEdMMM)
        lblTemperature.text = (day.maxTemp?.toTempNonSpaceString() ?? "") + " / " + (day.minTemp?.toTempNonSpaceString() ?? "")
        lblDescription.text = day.weatherDescription()
        lblRainPercent.text = "\(day.pop ?? 0)%"
        lblRainPercent.isHidden = (day.pop ?? 0) <= 0
        imgWeatherStatus.image = UIImage(named: day.weather?.icon ?? "")
    }
}
