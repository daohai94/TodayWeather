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
    
    func setUp(notification:NotificationSetting) {
        lblNotificationName.text = notification.name.rawValue
        lblNotificationDescription.text = notification.description
        switch notification.name {
        case .time:
            switchModeNotification.isHidden = true
            switchModeNotification.isUserInteractionEnabled = false
            break
        case .daily:
            switchModeNotification.isHidden = false
            switchModeNotification.isUserInteractionEnabled = true
            switchModeNotification.isOn = AppManager.currentUserSetting!.isEnabledDailyNotification
            switchModeNotification.setOn(AppManager.currentUserSetting!.isEnabledDailyNotification, animated: true)
            break
        case .rainAndSnowAlarm:
            switchModeNotification.isHidden = false
            switchModeNotification.isUserInteractionEnabled = true
            switchModeNotification.isOn = AppManager.currentUserSetting!.isEnabledRainSnowAlarm
            switchModeNotification.setOn(AppManager.currentUserSetting!.isEnabledRainSnowAlarm, animated: true)
            break
        case .severeAlert:
            switchModeNotification.isHidden = false
            switchModeNotification.isUserInteractionEnabled = true
            switchModeNotification.isOn = AppManager.currentUserSetting!.isEnabledSevereAlert
            switchModeNotification.setOn(AppManager.currentUserSetting!.isEnabledSevereAlert, animated: true)
            break
        default:
            break
        }
    }
}
