//
//  LaunchViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import RealmSwift

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
        self.checkUserSetting()
    }
    
    func initComponent() {
        self.navigationController?.isNavigationBarHidden = true
    }

    func checkUserSetting() {
        let userSetting = UserSettingManager.shared.getUserSetting()
        if userSetting.userName == nil {
            self.openSplashView()
        }else {
            AppManager.currentUserSetting = userSetting
            self.openHomeView()
        }
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
