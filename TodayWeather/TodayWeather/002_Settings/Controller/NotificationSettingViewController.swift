//
//  NotificationSettingViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class NotificationSettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications:[NotificationSetting] = []
    var notificationSettingCompleteCallBack:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initNotificationItems()
        self.initComponent()
    }
    
    func initNotificationItems() {
        self.notifications.append(NotificationSetting(name: .daily, description: "On"))
        self.notifications.append(NotificationSetting(name: .time, description: "8:00 AM"))
        self.notifications.append(NotificationSetting(name: .severeAlert, description: "On"))
        self.notifications.append(NotificationSetting(name: .rainAndSnowAlarm, description: "Alerts you when rain, snow is approaching"))
    }
    
    
    func initComponent() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.registerCell()
    }
    
    func registerCell() {
        self.tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
    }
    
    @objc func switchModeNotificationValueChanged(_ sender:UISwitch) {
        switch self.notifications[sender.tag].name {
        case .daily:
            AppManager.currentUserSetting!.isEnabledDailyNotification = sender.isOn
            self.notifications[sender.tag].description = sender.isOn ? "On" : "Off"
            break
        case .rainAndSnowAlarm:
            AppManager.currentUserSetting!.isEnabledRainSnowAlarm = sender.isOn
            break
        case .severeAlert:
            AppManager.currentUserSetting!.isEnabledSevereAlert = sender.isOn
            self.notifications[sender.tag].description = sender.isOn ? "On" : "Off"
            break
        default:
            break
        }
        self.tableView.reloadData()
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.notificationSettingCompleteCallBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK: Tableview delegate, datasource
extension NotificationSettingViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.switchModeNotification.tag = indexPath.row
        cell.switchModeNotification.addTarget(self, action: #selector(self.switchModeNotificationValueChanged(_:)), for: .valueChanged)
        cell.setUp(notification: self.notifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
