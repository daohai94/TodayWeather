//
//  NotificationSettingViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class NotificationSettingViewController: BaseViewController {
    
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
        self.notifications.append(NotificationSetting(name: .daily, description: AppManager.currentUserSetting!.isEnabledDailyNotification ? "On" : "Off"))
        self.notifications.append(NotificationSetting(name: .time, description: AppManager.currentUserSetting!.timeNotification.Date2String(format: "h:mm a")))
        self.notifications.append(NotificationSetting(name: .severeAlert, description: AppManager.currentUserSetting!.isEnabledSevereAlert ? "On" : "Off"))
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
            print("HAIDT switchStatus: \(sender.isOn)")
            if sender.isOn {
                self.checkAuthorizationNotification(withCompletionHandler: {isAllow in
                    if isAllow {
                        DispatchQueue.main.async {
                            AppManager.currentUserSetting!.isEnabledDailyNotification = true
                            self.notifications[sender.tag].description = "On"
                            self.scheduleDailyNotification()
                            self.tableView.reloadData()
                            self.notificationSettingCompleteCallBack?()
                        }
                        
                    }else {
                        print("HAIDT need allow authorizationNotification")
                        DispatchQueue.main.async {
                            AppManager.currentUserSetting!.isEnabledDailyNotification = false
                            self.notifications[sender.tag].description = "Off"
                            self.tableView.reloadData()
                            self.notificationSettingCompleteCallBack?()
                        }
                    }
                })
            }else {
                self.checkAuthorizationNotification(withCompletionHandler: {isAllow in
                    if isAllow {
                        DispatchQueue.main.async {
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [AppManager.dailyNotificationIdentify])
                            AppManager.currentUserSetting!.isEnabledDailyNotification = false
                            self.notifications[sender.tag].description = "Off"
                            self.tableView.reloadData()
                            self.notificationSettingCompleteCallBack?()
                        }                        
                    }
                })
            }
            break
        case .rainAndSnowAlarm:
            AppManager.currentUserSetting!.isEnabledRainSnowAlarm = sender.isOn
            self.notificationSettingCompleteCallBack?()
            self.tableView.reloadData()
            break
        case .severeAlert:
            AppManager.currentUserSetting!.isEnabledSevereAlert = sender.isOn
            self.notifications[sender.tag].description = sender.isOn ? "On" : "Off"
            self.notificationSettingCompleteCallBack?()
            self.tableView.reloadData()
            break
        default:
            break
        }
        
        
    }
    
    func openTimePicker() {
        let timePickerVC = UIStoryboard(name: AppStoryboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.timePickerVC.rawValue) as! TimePickerViewController
        timePickerVC.pickTimeCompleteCallBack = { [weak self] date in
            guard let index = self?.notifications.firstIndex(where: {$0.name == .time}) else { return }
            AppManager.currentUserSetting!.timeNotification = date
            self?.notifications[index].description = date.Date2String(format: "h:mm a")
            self?.reScheduleNotification()
            self?.tableView.reloadData()
            self?.notificationSettingCompleteCallBack?()
        }
        self.addChildVC(viewController: timePickerVC)
    }
    
    func reScheduleNotification() {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {settings in
            if settings.authorizationStatus == .authorized {
                if AppManager.currentUserSetting!.isEnabledDailyNotification {
                    self.scheduleDailyNotification()
                }
            }else {
                self.requestAuthorizationNotification()
            }
        })
    }
    
    func addChildVC(viewController:UIViewController) {
        self.addChild(viewController)
        self.view.frame = viewController.view.frame
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        //        self.notificationSettingCompleteCallBack?()
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
        cell.selectionStyle = .none
        cell.setUp(notification: self.notifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.notifications[indexPath.row].name == .time {
            self.openTimePicker()
        }
        else{
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
