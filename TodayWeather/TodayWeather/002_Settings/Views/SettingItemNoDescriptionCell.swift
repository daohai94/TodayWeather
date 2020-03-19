//
//  SettingItemNoDescriptionCell.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class SettingItemNoDescriptionCell: UITableViewCell {

    @IBOutlet weak var lblSettingItemName: UILabel!
    @IBOutlet weak var btnSettingItem: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(setting:Setting) {
        lblSettingItemName.text = setting.item.rawValue
    }
    
}
