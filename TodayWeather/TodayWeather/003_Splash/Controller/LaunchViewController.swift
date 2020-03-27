//
//  LaunchViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
        self.checkUserSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func initComponent() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func checkUserSetting() {
        AppManager.currentUserSetting = UserSettingStoreManager().getUserSetting(byId: 1)
        print("HAIDT userSetting: \(AppManager.currentUserSetting!)")
        if AppManager.currentUserSetting!.userName == "" {
            self.openSplashView()
        }else {
            self.openHomeView()
        }
        
        self.requestAuthorizationNotification()
        
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
