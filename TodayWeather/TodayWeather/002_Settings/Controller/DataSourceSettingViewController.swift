//
//  DataSourceSettingViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class DataSourceSettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSources:[DataSourceSetting] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initDataSourceItems()
        self.initComponent()
    }
    
    func initDataSourceItems() {
        self.dataSources.append(DataSourceSetting(name: "Weatherbit.io", description: "Cloudy", currentTemperature: 24))
    }
    
    func initComponent() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.registerCell()
    }
    
    func registerCell() {
        self.tableView.register(UINib(nibName: "DataSourceCell", bundle: nil), forCellReuseIdentifier: "DataSourceCell")
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Tableview delegate, datasource

extension DataSourceSettingViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataSourceCell", for: indexPath) as! DataSourceCell
        cell.setUp(dataSource: self.dataSources[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
