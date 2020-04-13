//
//  HomeViewController.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/18/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import CoreLocation
import PagingMenuController

class HomeViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuBackgroundView: UIView!
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionview: UICollectionView!

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initComponent()
        locationManager.delegate = self
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
    }

    func getWeather(_ lat: Double, long: Double) {
        _ = ApiClient.getWeather(lat: lat, long: long, success: { (data) in
            print(data)
        }, fail: { (statusCode, error) in
            print(error)
        })
    }

    func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()

        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            // show alert to user telling them they need to allow location data to use some feature of your app
            return
        }

        // if haven't show location permission dialog before, show it to user
        if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()

            // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
            // locationManager.requestAlwaysAuthorization()
            return
        }

        // at this point the authorization status is authorized
        // request location data once
        locationManager.requestLocation()

        // start monitoring location data and get notified whenever there is change in location data / every few seconds, until stopUpdatingLocation() is called
        // locationManager.startUpdatingLocation()
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
            // do some thing
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

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")

        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
            manager.requestLocation()
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
            manager.requestLocation()
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            //self.latitudeLabel.text = "\(location.coordinate.latitude)"
            //self.longitudeLabel.text = "\(location.coordinate.longitude)"
            print("lat: \(location.coordinate.latitude)")
            print("long: \(location.coordinate.longitude)")
            getWeather(location.coordinate.latitude, long: location.coordinate.longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
