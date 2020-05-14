//
//  AddLocationViewController.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var cities = [City]()
    var addLocationSuccess:((City, Int)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tfLocation.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange() {
        if tfLocation.text?.isEmpty ?? false {
            cities = []
            self.tableview.reloadData()
        } else {
            let text = self.tfLocation.text ?? ""
            DispatchQueue.global().async {
                let city = AppManager.cities.filter { (city) -> Bool in
                    return (city.name?.lowercased().contains(text) ?? false) || (city.coutry_name?.lowercased().contains(text) ?? false)
                }
                print(city.count)
                self.cities = city.count > 5 ? city.prefix(6).dropLast(): city
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        }
    }
}

extension AddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as! AddressTableViewCell
        cell.setData(cities[indexPath.row])
        return cell
    }
}

extension AddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        var saved = AppManager.savedCities
        saved.append(city)
        AppManager.savedCities = saved
        addLocationSuccess?(city, saved.count - 1)
        self.navigationController?.popViewController(animated: true)
    }
}

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ add: City) {
        nameLabel.text = add.name
        addressLabel.text = (add.coutry_name ?? "") + ", " + (add.coutry_code ?? "")
    }
}
