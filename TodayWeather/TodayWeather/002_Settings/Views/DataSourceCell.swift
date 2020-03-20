//
//  DataSourceCell.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class DataSourceCell: UITableViewCell {

    @IBOutlet weak var imgRadioButton: UIImageView!
    @IBOutlet weak var lblDataSourceName: UILabel!
    @IBOutlet weak var lblDataSourceDescription: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUp(dataSource:DataSource) {
        lblDataSourceName.text = dataSource.name
        lblDataSourceDescription.text = dataSource.description
        lblTemperature.text = "\(dataSource.currentTemperature)°"
    }
}
