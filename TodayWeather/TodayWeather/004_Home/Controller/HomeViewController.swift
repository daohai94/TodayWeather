//
//  HomeViewController.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/18/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuBackgroundView: UIView!
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
    }
    func initComponent() {
        self.menuBackgroundView.isHidden = true
        self.menuBackgroundView.isUserInteractionEnabled = false
        self.menuTrailingConstraint.constant = -menuView.bounds.width
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuBackgroundViewTappedHandle(_:)))
        self.menuBackgroundView.addGestureRecognizer(tapGesture)
        guard let menuVC = UIStoryboard(name: AppStoryboard.menu.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.menuVC.rawValue) as? MenuViewController else {
            print("HAIDT - initComponent: MenuViewController is nil")
            return
        }
        menuVC.closeMenuCallBack = { [weak self] in
            self?.closeMenuView(completion: nil)
        }
        menuVC.openSettingsCallBack = { [weak self] in
            self?.closeMenuView(completion: {
                self?.openSettingsViewController()
            })
        }
        self.addChildVC(intoView: self.menuView, viewController: menuVC)
    }
    
    func addChildVC(intoView view:UIView,viewController:UIViewController) {
        self.addChild(viewController)
        view.frame = viewController.view.frame
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    func closeMenuView(completion:(()->Void)?) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.menuBackgroundView.isHidden = true
            self.menuBackgroundView.isUserInteractionEnabled = false
            self.menuTrailingConstraint.constant = -self.menuView.bounds.width
            self.view.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
    func openSettingsViewController() {
        guard let settingsVC = UIStoryboard(name: AppStoryboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.settingsVC.rawValue) as? SettingsViewController else {
            print("HAIDT - initComponent: SettingsViewController is nil")
            return
        }
        settingsVC.closeSettingCallBack = { [weak self] in
            print("HAIDT userSetting: \(AppManager.currentUserSetting!)")
            DispatchQueue.main.async {
                UserSettingStoreManager().updateUserSetting(userSetting: AppManager.currentUserSetting!)
            }
        }
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func openMenuView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.menuBackgroundView.isHidden = false
            self.menuBackgroundView.isUserInteractionEnabled = true
            self.menuTrailingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func menuBackgroundViewTappedHandle(_ gesture:UITapGestureRecognizer){
        self.closeMenuView(completion: nil)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        self.openMenuView()
    }
    
    
}
