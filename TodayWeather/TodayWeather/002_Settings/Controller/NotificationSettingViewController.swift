//
//  NotificationSettingViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class NotificationSettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var notifications:[Notification] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initNotificationItems()
        self.initComponent()
    }
    
    func initNotificationItems() {
        self.notifications.append(Notification(name: .daily, description: "On"))
        self.notifications.append(Notification(name: .time, description: "8:00 AM"))
        self.notifications.append(Notification(name: .severeAlert, description: "On"))
        self.notifications.append(Notification(name: .rainAndSnowAlarm, description: "Alerts you when rain, snow is approaching"))
    }
    
    
    func initComponent() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.registerCell()
    }
    
    func registerCell() {
        self.tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

//MARK: Tableview delegate, datasource
extension NotificationSettingViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.setUp(notification: self.notifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
