//
//  LaunchViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/23/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import SwiftyJSON

class LaunchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initData()
        self.initComponent()
        self.checkUserSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func initData() {
        if let path = Bundle.main.path(forResource: "cities_full", ofType: "json") {
            var cities:[City] = []
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                print("DataCount: \(data.count)")
                DispatchQueue.global(qos: .background).async {
                    if let json = try? JSON(data: data,options: .allowFragments) {
                        print("json: \(json.array?.count) - \(Date())")
                        if let array = json.array{
                            for item in array {
                                let city = City(id: item["city_id"].int64Value, lon: item["lon"].floatValue, lat: item["lat"].floatValue, coutry_name: item["country_full"].stringValue, coutry_code: item["country_code"].stringValue, state_code: item["state_code"].stringValue, name: item["city_name"].stringValue)
                                cities.append(city)
                                
                            }
                        }
                        print("cities: \(cities.count) - \(Date())")
                    }
                }
                AppManager.cities = cities
            } catch {
                // handle error
            }
        }
        
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
