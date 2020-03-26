//
//  LaunchViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var notificationCenter:UNUserNotificationCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
        self.checkAuthorizationNotification()
        self.checkUserSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func initComponent() {
        self.navigationController?.isNavigationBarHidden = true
        self.notificationCenter = UNUserNotificationCenter.current()
        self.notificationCenter.delegate = self
    }
    
    func checkAuthorizationNotification() {
        if !UIApplication.shared.isRegisteredForRemoteNotifications {
            self.showRequestAuthorizationNotification()
        }
    }

    func checkUserSetting() {
        let userSetting = UserSettingStoreManager().getUserSetting(byId: 1)
        print("userSetting: \(userSetting)")
        if userSetting.userName == "" {
            self.openSplashView()
        }else {
            print("user: \(userSetting)")
            AppManager.currentUserSetting = userSetting
            self.openHomeView()
        }
    }
    func showRequestAuthorizationNotification() {
        self.notificationCenter.requestAuthorization(options: [.alert,.badge], completionHandler: { (didAllow, error) in
            if error != nil {
                return
            }
            if didAllow {
                print("Allow")
            } else {
                print("Not Allow")
            }
        })
    }
    
    func openSplashView() {
        let vc = UIStoryboard(name: AppStoryboard.splash.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.splashVC.rawValue) as! SplashViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHomeView() {
        let vc = UIStoryboard(name: AppStoryboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.homeVC.rawValue) as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - Notifications

extension LaunchViewController:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
}
