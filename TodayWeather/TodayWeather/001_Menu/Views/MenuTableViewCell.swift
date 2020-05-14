//
//  MenuTableViewCell.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/19/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var btnOption: UIButton!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: CurrentWeatherDataModelElement) {
        locationLabel.text = data.cityName
        currentTempLabel.text = data.temp?.toTempString()
        weatherImageView.image = UIImage(named: data.weather?.icon ?? "")
    }
    
}
