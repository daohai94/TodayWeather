//
//  SplashScene1ViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class SplashScene1ViewController: UIViewController {
    var nextButtonCallBack:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.nextButtonCallBack?()
    }
    
   

}
