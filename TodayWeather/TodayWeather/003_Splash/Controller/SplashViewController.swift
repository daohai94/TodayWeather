//
//  SplashViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    var pageViewController:UIPageViewController!
    var scene1VC:SplashScene1ViewController!
    var scene2VC:SplashScene2ViewController!
    var viewControllers:[UIViewController] = []
    var indexVC:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
    }
    
    func initComponent() {
        // custom pagecontrol page view controller
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor(hexString: "#333333")
        pageControl.currentPageIndicatorTintColor = UIColor(hexString: "#F7CA75")
        pageControl.backgroundColor = UIColor.clear
        
        // init scenes of splash
        self.scene1VC = UIStoryboard(name: AppStoryboard.splash.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.splashScene1VC.rawValue) as? SplashScene1ViewController
        self.scene2VC = UIStoryboard(name: AppStoryboard.splash.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.splashScene2VC.rawValue) as? SplashScene2ViewController
        self.viewControllers = [self.scene1VC,self.scene2VC]
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.setViewControllers([self.scene1VC], direction: .forward, animated: true, completion: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.scene1VC.nextButtonCallBack = { [weak self] in
            self?.pageViewController.setViewControllers([self!.scene2VC], direction: .forward, animated: true, completion: nil)
        }
        self.scene2VC.inputCompleteCallback = { [weak self] in
            self?.openHomeView()
        }
        self.addChildVC(viewController: pageViewController)
    }
    
    func addChildVC(viewController:UIViewController) {
        self.addChild(viewController)
        self.view.frame = viewController.view.frame
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func openHomeView() {
        let vc = UIStoryboard(name: AppStoryboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.homeVC.rawValue) as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - UIPageViewController delegate, datasource
extension SplashViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.viewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard self.viewControllers.count > previousIndex else {
            return nil
        }
        return self.viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.viewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = self.viewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return self.viewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.viewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        return 0
    }
    
}
