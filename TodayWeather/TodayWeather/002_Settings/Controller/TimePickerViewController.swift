//
//  TimePickerViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/26/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    var pickTimeCompleteCallBack:((_ date:Date)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
    }
    
    func initComponent() {
        self.timePicker.setDate(AppManager.currentUserSetting!.timeNotification, animated: true)
    }
    
    func hideTimePicker() {
        self.view.removeFromSuperview()
        self.removeFromParent()
        self.willMove(toParent: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.hideTimePicker()
    }
    @IBAction func okButtonTapped(_ sender: Any) {        
        self.pickTimeCompleteCallBack?(self.timePicker.date)
        self.hideTimePicker()
    }
    
}
