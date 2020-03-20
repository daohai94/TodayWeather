//
//  NotificationCell.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lblNotificationName: UILabel!
    @IBOutlet weak var lblNotificationDescription: UILabel!
    @IBOutlet weak var switchModeNotification: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(notification:Notification) {
        lblNotificationName.text = notification.name.rawValue
        lblNotificationDescription.text = notification.description
        if notification.name == .time {
            switchModeNotification.isHidden = true
            switchModeNotification.isUserInteractionEnabled = false
        }
    }
}
