//
//  SettingsViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/19/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var settings:[Setting] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initSettingItems()
        self.initComponent()
    }
    
    func initSettingItems() {
        self.settings.append(Setting(name: .picture, description: AppManager.currentUserSetting!.isEnabledPicture ? "On" : "Off"))
        self.settings.append(Setting(name: .iconSet, description: ""))
        self.settings.append(Setting(name: .unit, description: ""))
        self.settings.append(Setting(name: .notification, description: ""))
        self.settings.append(Setting(name: .dataSource, description: AppManager.currentUserSetting!.dataSource))
        self.settings.append(Setting(name: .yourName, description: AppManager.currentUserSetting!.userName))
        self.settings.append(Setting(name: .language, description: AppManager.currentUserSetting!.language))
        self.settings.append(Setting(name: .version, description: "v1.0"))
    }
    
    func initComponent() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.registerCell()
    }
    
    
    func registerCell() {
        tableView.register(UINib(nibName: "SettingItemNoDescriptionCell", bundle: nil), forCellReuseIdentifier: "SettingItemNoDescriptionCell")
        tableView.register(UINib(nibName: "SettingItemHasDescriptionCell", bundle: nil), forCellReuseIdentifier: "SettingItemHasDescriptionCell")
    }
    

    @objc func settingItemTapped(_ sender:UIButton){
        self.openSettingItemView(setting: self.settings[sender.tag])
    }
    
    @objc func switchSettingValueChanged(_ sender:UISwitch) {
        switch settings[sender.tag].name {
        case .picture:
            AppManager.currentUserSetting!.isEnabledPicture = sender.isOn
            settings[sender.tag].description = sender.isOn ? "On" : "Off"
            break
        default:
            break
        }
        self.tableView.reloadData()
    }
    
    func openSettingItemView(setting:Setting) {
        switch setting.name {
        case .iconSet:
            print("HAIDT - open setting iconSet")
            let iconSetSettingVC = UIStoryboard(name: AppStoryboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.iconSetSettingVC.rawValue) as! IconSetSettingViewController
            self.navigationController?.pushViewController(iconSetSettingVC, animated: true)
            break
        case .unit:
           print("HAIDT - open setting unit")
           let unitSettingVC = UIStoryboard(name: AppStoryboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.unitSettingVC.rawValue) as! UnitSettingViewController
           self.navigationController?.pushViewController(unitSettingVC, animated: true)
            break
        case .notification:
            print("HAIDT - open setting notification")
            let notificationSettingVC = UIStoryboard(name: AppStoryboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.notificationSettingVC.rawValue) as! NotificationSettingViewController
            self.navigationController?.pushViewController(notificationSettingVC, animated: true)
            break
        case .dataSource:
            print("HAIDT - open setting dataSource")
            let dataSourceSettingVC = UIStoryboard(name: AppStoryboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.dataSourceSettingVC.rawValue) as! DataSourceSettingViewController
            self.navigationController?.pushViewController(dataSourceSettingVC, animated: true)
            break
        case .yourName:
            print("HAIDT - open setting yourName")
            self.openNameSettingPopup()
            break
        case .language:
            print("HAIDT - open setting language")
            let languageSettingVC = UIStoryboard(name: AppStoryboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppViewController.languageSettingVC.rawValue) as! LanguageSettingViewController
            self.navigationController?.pushViewController(languageSettingVC, animated: true)
            break
        default:
            break
        }
    }
    
    func openNameSettingPopup() {
        let alertInputName = UIAlertController(title: "Your Name", message: "", preferredStyle: .alert)

        // cancel button
        alertInputName.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        // OK button
        alertInputName.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
           
        }))
        
        // Text field
        alertInputName.addTextField(configurationHandler: { textField in
            textField.text = "Haipro"
            textField.placeholder = "Your Name"
        })
        self.present(alertInputName, animated: true, completion: nil)
    }
    
    @IBAction func closeSettingsButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

//MARK: - Table view delegate, datasource
extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.settings[indexPath.row].name {
        case .iconSet,.unit,.notification:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingItemNoDescriptionCell", for: indexPath) as! SettingItemNoDescriptionCell
            cell.btnSettingItem.tag = indexPath.row
            cell.btnSettingItem.addTarget(self, action: #selector(self.settingItemTapped(_:)), for: .touchUpInside)
            cell.setUp(setting: self.settings[indexPath.row])
            return cell
        case .picture,.dataSource,.yourName,.language,.version:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingItemHasDescriptionCell", for: indexPath) as! SettingItemHasDescriptionCell
            cell.btnSettingItem.tag = indexPath.row
            cell.switchSetting.tag = indexPath.row
            cell.switchSetting.addTarget(self, action: #selector(self.switchSettingValueChanged(_:)), for: .valueChanged)
            cell.btnSettingItem.addTarget(self, action: #selector(self.settingItemTapped(_:)), for: .touchUpInside)
            cell.setUp(setting: self.settings[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    

}
