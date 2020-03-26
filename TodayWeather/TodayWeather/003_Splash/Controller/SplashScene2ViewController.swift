//
//  SplashScene2ViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class SplashScene2ViewController: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    var inputCompleteCallback:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tfUserName.text = ""
        self.view.endEditing(true)
    }
    
    func initComponent() {
        tfUserName.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyBoard(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func validateTextField() {
        let str = tfUserName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if str?.count ?? 0 < 1 {
            self.alertValidateTextField()
        }
        else{
            self.updateUserSetting()
            self.inputCompleteCallback?()
        }
    }
    
    func alertValidateTextField() {
        let alert = UIAlertController(title: "Warning", message: "Input name must at least 1 character", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUserSetting() {
        var userSetting = UserSettingStoreManager().getUserSetting(byId: 1)
        userSetting.userName = tfUserName.text!
        UserSettingStoreManager().updateUserSetting(userSetting: userSetting)
        AppManager.currentUserSetting = UserSettingStoreManager().getUserSetting(byId: 1)
    }
    
    
    
    @objc func dismissKeyBoard(_ tap:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.validateTextField()
    }
    
    
    

}

extension SplashScene2ViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
