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
    @IBOutlet weak var menuViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuBackgroundView: UIView!
    
    
    var isOpenMenu:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initComponent()
    }
    func initComponent() {
        self.menuBackgroundView.isHidden = true
        self.menuBackgroundView.isUserInteractionEnabled = false
        guard let menuVC = UIStoryboard(name: AppStoryboard.menu.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.menuVC.rawValue) as? MenuViewController else {
            print("HAIDT - initComponent: MenuViewController is nil")
            return
        }
        addChildVC(intoView: self.menuView, viewController: menuVC)
    }
    
    func addChildVC(intoView view:UIView,viewController:UIViewController) {
        view.frame = viewController.view.frame
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func toggleMenuView(isOpen:Bool) {
        if !isOpen{
            self.isOpenMenu = true
            self.menuBackgroundView.isHidden = false
            self.menuBackgroundView.isUserInteractionEnabled = true
            self.menuViewTrailingConstraint.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }else{
            self.isOpenMenu = false
            self.menuBackgroundView.isHidden = true
            self.menuBackgroundView.isUserInteractionEnabled = false
            self.menuViewTrailingConstraint.constant = -320
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        toggleMenuView(isOpen: self.isOpenMenu)
    }
    

}
