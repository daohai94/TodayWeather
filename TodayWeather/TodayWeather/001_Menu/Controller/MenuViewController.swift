//
//  MenuViewController.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/18/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var closeMenuCallBack:(()->())?
    var openSettingsCallBack:(()->())?
    var openAddLocationView:(()->())?
    var deleteLocation: (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initComponent()
    }
    
    func initComponent() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.registerCell()
    }
    
    func registerCell() {
        self.tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    @IBAction func addLocationButtonTapped(_ sender: Any) {
        self.openAddLocationView?()
    }
    
    @IBAction func closeMenuButtonTapped(_ sender: Any) {
        self.closeMenuCallBack?()
    }
    
    @IBAction func openSettingsButtonTapped(_ sender: Any) {
        self.openSettingsCallBack?()
    }
    
    @objc func optionsButtonTapped(_ sender:UIButton) {
        let alertDelete = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertDelete.view.tintColor = .black
        alertDelete.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            AppManager.weatherData.remove(at: sender.tag)
            var saved = AppManager.cities
            saved.remove(at: sender.tag)
            AppManager.cities = saved
            self.tableView.reloadData()
            self.deleteLocation?()
        }))
        alertDelete.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertDelete, animated: true, completion: nil)
    }

}
//MARK: - Table view delegate - datasource
extension MenuViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.setData(AppManager.weatherData[indexPath.row])
        cell.btnOption.tag = indexPath.row
        cell.btnOption.addTarget(self, action: #selector(self.optionsButtonTapped(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt: \(indexPath.row)")
    }
    
    
}
