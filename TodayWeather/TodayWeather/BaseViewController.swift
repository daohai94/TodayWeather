//
//  BaseViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/27/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import UserNotifications

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Notifications function
    
    func requestAuthorizationNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge], completionHandler: { (isAllow, error) in
            if error != nil {
                return
            }
            print("HAIDT isAllowAuthorizationNotification:\(isAllow)")
            if !isAllow {
                AppManager.currentUserSetting!.isEnabledDailyNotification = false
                DispatchQueue.main.async {
                    UserSettingStoreManager().updateUserSetting(userSetting: AppManager.currentUserSetting!)
                }
                print("HAIDT userSetting: \(AppManager.currentUserSetting!)")
            }
        })
    }
    
    func checkAuthorizationNotification(withCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { settings in
            if settings.authorizationStatus == .authorized{
                completionHandler(true)
            }
            else {
                completionHandler(false)
            }
        })
    }
    
    func scheduleDailyNotification() {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {settings in
            switch settings.authorizationStatus {
            case .authorized:
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [AppManager.dailyNotificationIdentify])
                UNUserNotificationCenter.current().delegate = self
                let content = UNMutableNotificationContent()
                content.title = "Thời tiết tại Hà Nội hôm nay"
                content.body = "Có mưa rào. Nhiệt độ: 27°C. Độ ẩm: 50%"
                content.categoryIdentifier = "notification"
                content.userInfo = ["data": "Fuck Together"]
                content.badge = 1
                var dateComponents = DateComponents()
                dateComponents.hour = Calendar.current.component(.hour, from: AppManager.currentUserSetting!.timeNotification)
                dateComponents.minute = Calendar.current.component(.minute, from: AppManager.currentUserSetting!.timeNotification)
                //                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: AppManager.dailyNotificationIdentify, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                break
            case .notDetermined,.provisional:
                self.requestAuthorizationNotification()
                break
            default:
                break
            }
        })
        
    }
    
}
//MARK: NotificationCenter Delegate

extension BaseViewController:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["data"] as? String {
            print("HAIDT Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("HAIDT Click notification")
            default:
                break
            }
        }
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge])
    }
}
