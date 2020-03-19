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
        self.settings.append(Setting(item: .picture, description: "On"))
        self.settings.append(Setting(item: .iconSet, description: ""))
        self.settings.append(Setting(item: .unit, description: ""))
        self.settings.append(Setting(item: .notification, description: ""))
        self.settings.append(Setting(item: .dataSource, description: "Weatherbit.io"))
        self.settings.append(Setting(item: .yourName, description: "Haipro"))
        self.settings.append(Setting(item: .language, description: "English"))
        self.settings.append(Setting(item: .version, description: "v1.0"))
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
        self.openSettingItemViewController(setting: self.settings[sender.tag])
    }
    
    func openSettingItemViewController(setting:Setting) {
        switch setting.item {
        case .iconSet:
            print("HAIDT - open setting iconSet")
            break
        case .unit:
           print("HAIDT - open setting unit")
            break
        case .notification:
            print("HAIDT - open setting notification")
            break
        case .dataSource:
            print("HAIDT - open setting dataSource")
            break
        case .yourName:
            print("HAIDT - open setting yourName")
            break
        case .language:
            print("HAIDT - open setting language")
            break
        default:
            break
        }
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
        switch self.settings[indexPath.row].item {
        case .iconSet,.unit,.notification:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingItemNoDescriptionCell", for: indexPath) as! SettingItemNoDescriptionCell
            cell.btnSettingItem.tag = indexPath.row
            cell.btnSettingItem.addTarget(self, action: #selector(self.settingItemTapped(_:)), for: .touchUpInside)
            cell.setUp(setting: self.settings[indexPath.row])
            return cell
        case .picture,.dataSource,.yourName,.language,.version:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingItemHasDescriptionCell", for: indexPath) as! SettingItemHasDescriptionCell
            cell.btnSettingItem.tag = indexPath.row
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
