//
//  ViewController.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/17/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        let vc = UIStoryboard(name: AppStoryboard.splash.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.splashVC.rawValue) as! SplashViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

