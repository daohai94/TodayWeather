//
//  MenuViewController.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/18/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var closeMenuCallBack:(()->())?
    var openSettingsCallBack:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   

    @IBAction func closeMenuButtonTapped(_ sender: Any) {
        self.closeMenuCallBack?()
    }
    @IBAction func openSettingsButtonTapped(_ sender: Any) {
        self.openSettingsCallBack?()
    }
    

}
