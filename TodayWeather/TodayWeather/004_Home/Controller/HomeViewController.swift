//
//  HomeViewController.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/18/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import PKHUD

class HomeViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuBackgroundView: UIView!
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var img: UIImageView!
    
    let locationManager = CLLocationManager()
//    var weather16Days: [[DailyWeatherDataModelElement]] = []
    let dispactGroup = DispatchGroup()
    var isLoading = true
    var menuVC: MenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponent()
        locationManager.delegate = self
        retriveCurrentLocation()
        collectionview.isHidden = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        loadSaveLocation()
        
    }
    
    func loadSaveLocation() {
        let cities = AppManager.savedCities
        if cities.isEmpty { return }
        HUD.show(.progress)
        for item in cities {
            let weather = WeatherDay()
            weather.lat = Double(item.lat)
            weather.lon = Double(item.lon)
            AppManager.weatherDayDatas.append(weather)
//            getWeather(Double(element.lat), long: Double(element.lon), index: index)
//            getDailyWeather(Double(element.lat), long: Double(element.lon), index: index)
        }
        
        getWeather(Double(cities[0].lat), long: Double(cities[0].lon), index: 0)
        getDailyWeather(Double(cities[0].lat), long: Double(cities[0].lon), index: 0)
        
        dispactGroup.notify(queue: .main) {
            HUD.flash(.success, delay: 1.0)
            self.isLoading = false
            self.collectionview.isHidden = false
            self.collectionview.reloadData()
        }
    }
    
    
//    func loadSaveLocation() {
//        let cities = AppManager.savedCities
//        if cities.isEmpty { return }
//        HUD.show(.progress)
//        for (index, element) in cities.enumerated() {
//            AppManager.weatherData.append(CurrentWeatherDataModelElement())
//            weather16Days.append([])
//            getWeather(Double(element.lat), long: Double(element.lon), index: index)
//            getDailyWeather(Double(element.lat), long: Double(element.lon), index: index)
//        }
//
//        dispactGroup.notify(queue: .main) {
//            HUD.flash(.success, delay: 1.0)
//            self.isLoading = false
//            self.collectionview.isHidden = false
//            self.collectionview.reloadData()
//        }
//    }
    
    func getWeather(_ lat: Double, long: Double, index: Int) {
        dispactGroup.enter()
        _ = ApiClient.getWeather(lat: lat, long: long, success: {[weak self] (data) in
            guard let weakSelf = self else { return }
            let jsonData = JSON(data)["data"]
            print("JSON: \(jsonData)")
            if let jsonArray = jsonData.array {
                if let currentWeatherJSON = jsonArray.first {
                    let current = CurrentWeatherDataModelElement(json: currentWeatherJSON)
//                    AppManager.weatherData.remove(at: index)
//                    AppManager.weatherData.insert(current, at: index)
                    let weather = AppManager.weatherDayDatas[index]
                    weather.current = current
                    weather.lastUpdateDate = Date()
                    
                }
            }
            weakSelf.dispactGroup.leave()
            
            }, fail: { (statusCode, error) in
                self.dispactGroup.leave()
                print(error)
        })
    }
    
    func getDailyWeather(_ lat: Double, long: Double, index: Int) {
        dispactGroup.enter()
        _ = ApiClient.getDailyWeather(lat: lat, long: long, success: {[weak self] (data) in
            guard let weakSelf = self else { return }
            let jsonData = JSON(data)["data"]
            print("JSON dayli: \(jsonData)")
            if let jsonArray = jsonData.array {
                var dailies = [DailyWeatherDataModelElement]()
                for item in jsonArray {
                    let daily = DailyWeatherDataModelElement(json: item)
                    dailies.append(daily)
                }
//                weakSelf.weather16Days.remove(at: index)
//                weakSelf.weather16Days.insert(dailies, at: index)//append(dailies)
                let weather = AppManager.weatherDayDatas[index]
                weather.dailyes = dailies
                weather.lastUpdateDate = Date()
            }
            weakSelf.dispactGroup.leave()
            }, fail: { (statusCode, error) in
                self.dispactGroup.leave()
                print(index)
                print(error)
        })
    }
    
    func getHourlyWeather(_ lat: Double, long: Double) {
        _ = ApiClient.getHourlyWeather(lat: lat, long: long, success: { (data) in
            let jsonData = JSON(data)["data"]
            print("JSON: \(jsonData)")
            //            if let currentWeatherModel = try? HourlyWeatherDataModel(data: jsonData.rawData()) {
            //                print("HAIDT: ---- \(currentWeatherModel)")
            //            }
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
        self.menuTrailingConstraint.constant = -1000
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuBackgroundViewTappedHandle(_:)))
        self.menuBackgroundView.addGestureRecognizer(tapGesture)
        guard let menuVC = UIStoryboard(name: AppStoryboard.menu.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.menuVC.rawValue) as? MenuViewController else {
            print("HAIDT - initComponent: MenuViewController is nil")
            return
        }
        self.menuVC = menuVC
        menuVC.closeMenuCallBack = { [weak self] in
            self?.closeMenuView(completion: nil)
        }
        menuVC.openSettingsCallBack = { [weak self] in
            self?.closeMenuView(completion: {
                self?.openSettingsViewController()
            })
        }
        menuVC.openAddLocationView = { [weak self] in
            self?.closeMenuView(completion: {
                self?.openAddLocationView()
            })
        }
        menuVC.deleteLocation = { [weak self] in
            self?.collectionview.reloadData()
            
            
        }
        self.addChildVC(intoView: self.menuView, viewController: menuVC)
        self.view.bringSubviewToFront(menuView)
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
    
    func openAddLocationView() {
        let addLocationVC = UIStoryboard(name: AppStoryboard.menu.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.addLocationVC.rawValue) as! AddLocationViewController
        addLocationVC.addLocationSuccess = { [weak self] city, index in
            guard let `self` = self else { return }
            HUD.show(.progress)
            let weather = WeatherDay()
            weather.lat = Double(city.lat)
            weather.lon = Double(city.lon)
            AppManager.weatherDayDatas.append(weather)
            self.getWeather(Double(city.lat), long: Double(city.lon), index: index)
            self.getDailyWeather(Double(city.lat), long: Double(city.lon), index: index)
            self.dispactGroup.notify(queue: .main) {
                HUD.flash(.success, delay: 1.0)
                self.isLoading = false
                self.collectionview.isHidden = false
                self.collectionview.reloadData()
            }
        }
        self.navigationController?.pushViewController(addLocationVC, animated: true)
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
            self.menuVC?.tableView.reloadData()
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
            var cities = AppManager.savedCities
            if cities.isEmpty {
                let city = City(id: 0, lon: Float(location.coordinate.longitude), lat: Float(location.coordinate.latitude), coutry_name: "current", coutry_code: nil, state_code: nil, name: nil)
                cities.append(city)
                AppManager.savedCities = cities
                loadSaveLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppManager.weatherDayDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        if isLoading { return cell}
        if indexPath.row < AppManager.weatherDayDatas.count {
            let weather = AppManager.weatherDayDatas[indexPath.row]
            if let current = weather.current {
                cell.setData(current)
                cell.setAirQuality(current)
            }
            if let daily = weather.dailyes, !daily.isEmpty {
                cell.setDaily(daily[0])
                cell.setSevenDays(days: daily.prefix(8).dropLast())
            }
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionview.visibleCells {
            if let indexPath = collectionview.indexPath(for: cell) {
                let weather = AppManager.weatherDayDatas[indexPath.row]
                if weather.current == nil, let lat = weather.lat, let lon = weather.lon {
                    HUD.show(.progress)
                    isLoading = true
                    getWeather(lat, long: lon, index: indexPath.row)
                }
                if weather.dailyes == nil, let lat = weather.lat, let lon = weather.lon {
                    if !isLoading {
                        HUD.show(.progress)
                    }
                    getDailyWeather(lat, long: lon, index: indexPath.row)
                }
                break
            }
        }
        if isLoading {
            self.dispactGroup.notify(queue: .main) {
                HUD.flash(.success, delay: 1.0)
                self.isLoading = false
                self.collectionview.isHidden = false
                self.collectionview.reloadData()
            }
        }
    }
}

class WeatherDay {
    var current: CurrentWeatherDataModelElement?
    var dailyes: [DailyWeatherDataModelElement]?
    var lat: Double?
    var lon: Double?
    var lastUpdateDate: Date?
}
