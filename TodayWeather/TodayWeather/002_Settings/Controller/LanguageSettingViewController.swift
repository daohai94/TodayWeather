//
//  LanguageSettingViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class LanguageSettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var languages:[LanguageSetting] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initLanguageItems()
        self.initComponent()
    }
    
    func initLanguageItems() {
        self.languages.append(LanguageSetting(name: Language.english.rawValue))
    }
    
    func initComponent() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.registerCell()
    }
    
    func registerCell() {
        self.tableView.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "LanguageCell")
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Tableview delegate, datasource
extension LanguageSettingViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        cell.setUp(language: self.languages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
