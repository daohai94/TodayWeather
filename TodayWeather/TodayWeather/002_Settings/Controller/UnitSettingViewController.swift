//
//  UnitSettingViewController.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/20/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit

class UnitSettingViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var btnFDegree: UIButton!
    @IBOutlet weak var btnCDegree: UIButton!
    @IBOutlet weak var btnMI: UIButton!
    @IBOutlet weak var btnKM: UIButton!
    @IBOutlet weak var btnMPH: UIButton!
    @IBOutlet weak var btnKPH: UIButton!
    @IBOutlet weak var btnKMH: UIButton!
    @IBOutlet weak var btnMS: UIButton!
    @IBOutlet weak var btnMBAR: UIButton!
    @IBOutlet weak var btnINHG: UIButton!
    @IBOutlet weak var btnPSI: UIButton!
    @IBOutlet weak var btnBAR: UIButton!
    @IBOutlet weak var btnMMHG: UIButton!
    
    var setupUnitCompleteCallBack:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initComponent()
    }
    
    func initComponent() {
        self.setupTemperatureButtons(withTemperatureUnit: TemperatureUnit(rawValue: AppManager.currentUserSetting!.temperatureUnit)!)
        self.setupDistanceButtons(withDistanceUnit: DistanceUnit(rawValue: AppManager.currentUserSetting!.distanceInit)!)
        self.setupSpeedButtons(withSpeedUnit: SpeedUnit(rawValue: AppManager.currentUserSetting!.speedUnit)!)
        self.setupPressureButtons(withPressureUnit: PressureUnit(rawValue: AppManager.currentUserSetting!.pressureUnit)!)
    }
    
    func setupTemperatureButtons(withTemperatureUnit tempUnit:TemperatureUnit) {
        switch tempUnit {
        case .C:
            btnCDegree.backgroundColor = UIColor(hexString: "#F6CB75")
            btnCDegree.setTitleColor(UIColor.black, for: .normal)
            btnFDegree.backgroundColor = UIColor.black
            btnFDegree.setTitleColor(UIColor.white, for: .normal)
            break
        case .F:
            btnFDegree.backgroundColor = UIColor(hexString: "#F6CB75")
            btnFDegree.setTitleColor(UIColor.black, for: .normal)
            btnCDegree.backgroundColor = UIColor.black
            btnCDegree.setTitleColor(UIColor.white, for: .normal)
            break
        default:
            break
        }
        
    }
    
    func setupDistanceButtons(withDistanceUnit distanceUnit:DistanceUnit)  {
        switch distanceUnit {
        case .mi:
            btnMI.backgroundColor = UIColor(hexString: "#F6CB75")
            btnMI.setTitleColor(UIColor.black, for: .normal)
            btnKM.backgroundColor = UIColor.black
            btnKM.setTitleColor(UIColor.white, for: .normal)
            break
        case .km:
            btnKM.backgroundColor = UIColor(hexString: "#F6CB75")
            btnKM.setTitleColor(UIColor.black, for: .normal)
            btnMI.backgroundColor = UIColor.black
            btnMI.setTitleColor(UIColor.white, for: .normal)
            break
        default:
            break
        }
    }
    
    func setupSpeedButtons(withSpeedUnit speedUnit:SpeedUnit) {
        switch speedUnit {
        case .mph:
            btnMPH.backgroundColor = UIColor(hexString: "#F6CB75")
            btnMPH.setTitleColor(UIColor.black, for: .normal)
            btnKPH.backgroundColor = UIColor.black
            btnKPH.setTitleColor(UIColor.white, for: .normal)
            btnKMH.backgroundColor = UIColor.black
            btnKMH.setTitleColor(UIColor.white, for: .normal)
            btnMS.backgroundColor = UIColor.black
            btnMS.setTitleColor(UIColor.white, for: .normal)
            break
        case .kph:
            btnKPH.backgroundColor = UIColor(hexString: "#F6CB75")
            btnKPH.setTitleColor(UIColor.black, for: .normal)
            btnMPH.backgroundColor = UIColor.black
            btnMPH.setTitleColor(UIColor.white, for: .normal)
            btnKMH.backgroundColor = UIColor.black
            btnKMH.setTitleColor(UIColor.white, for: .normal)
            btnMS.backgroundColor = UIColor.black
            btnMS.setTitleColor(UIColor.white, for: .normal)
            break
        case .kmh:
            btnKMH.backgroundColor = UIColor(hexString: "#F6CB75")
            btnKMH.setTitleColor(UIColor.black, for: .normal)
            btnMPH.backgroundColor = UIColor.black
            btnMPH.setTitleColor(UIColor.white, for: .normal)
            btnKPH.backgroundColor = UIColor.black
            btnKPH.setTitleColor(UIColor.white, for: .normal)
            btnMS.backgroundColor = UIColor.black
            btnMS.setTitleColor(UIColor.white, for: .normal)
            break
        case .ms:
            btnMS.backgroundColor = UIColor(hexString: "#F6CB75")
            btnMS.setTitleColor(UIColor.black, for: .normal)
            btnMPH.backgroundColor = UIColor.black
            btnMPH.setTitleColor(UIColor.white, for: .normal)
            btnKMH.backgroundColor = UIColor.black
            btnKMH.setTitleColor(UIColor.white, for: .normal)
            btnKPH.backgroundColor = UIColor.black
            btnKPH.setTitleColor(UIColor.white, for: .normal)
            break
        default:
            break
        }
    }
    
    func setupPressureButtons(withPressureUnit pressureUnit:PressureUnit) {
        switch pressureUnit {
        case .mBar:
            btnMBAR.backgroundColor = UIColor(hexString: "#F6CB75")
            btnMBAR.setTitleColor(UIColor.black, for: .normal)
            btnINHG.backgroundColor = UIColor.black
            btnINHG.setTitleColor(UIColor.white, for: .normal)
            btnPSI.backgroundColor = UIColor.black
            btnPSI.setTitleColor(UIColor.white, for: .normal)
            btnBAR.backgroundColor = UIColor.black
            btnBAR.setTitleColor(UIColor.white, for: .normal)
            btnMMHG.backgroundColor = UIColor.black
            btnMMHG.setTitleColor(UIColor.white, for: .normal)
            break
        case .inHg:
            btnINHG.backgroundColor = UIColor(hexString: "#F6CB75")
            btnINHG.setTitleColor(UIColor.black, for: .normal)
            btnMBAR.backgroundColor = UIColor.black
            btnMBAR.setTitleColor(UIColor.white, for: .normal)
            btnPSI.backgroundColor = UIColor.black
            btnPSI.setTitleColor(UIColor.white, for: .normal)
            btnBAR.backgroundColor = UIColor.black
            btnBAR.setTitleColor(UIColor.white, for: .normal)
            btnMMHG.backgroundColor = UIColor.black
            btnMMHG.setTitleColor(UIColor.white, for: .normal)
            break
        case .psi:
            btnPSI.backgroundColor = UIColor(hexString: "#F6CB75")
            btnPSI.setTitleColor(UIColor.black, for: .normal)
            btnINHG.backgroundColor = UIColor.black
            btnINHG.setTitleColor(UIColor.white, for: .normal)
            btnMBAR.backgroundColor = UIColor.black
            btnMBAR.setTitleColor(UIColor.white, for: .normal)
            btnBAR.backgroundColor = UIColor.black
            btnBAR.setTitleColor(UIColor.white, for: .normal)
            btnMMHG.backgroundColor = UIColor.black
            btnMMHG.setTitleColor(UIColor.white, for: .normal)
            break
        case .bar:
            btnBAR.backgroundColor = UIColor(hexString: "#F6CB75")
            btnBAR.setTitleColor(UIColor.black, for: .normal)
            btnINHG.backgroundColor = UIColor.black
            btnINHG.setTitleColor(UIColor.white, for: .normal)
            btnPSI.backgroundColor = UIColor.black
            btnPSI.setTitleColor(UIColor.white, for: .normal)
            btnMBAR.backgroundColor = UIColor.black
            btnMBAR.setTitleColor(UIColor.white, for: .normal)
            btnMMHG.backgroundColor = UIColor.black
            btnMMHG.setTitleColor(UIColor.white, for: .normal)
            break
        case .mmHg:
            btnMMHG.backgroundColor = UIColor(hexString: "#F6CB75")
            btnMMHG.setTitleColor(UIColor.black, for: .normal)
            btnINHG.backgroundColor = UIColor.black
            btnINHG.setTitleColor(UIColor.white, for: .normal)
            btnPSI.backgroundColor = UIColor.black
            btnPSI.setTitleColor(UIColor.white, for: .normal)
            btnBAR.backgroundColor = UIColor.black
            btnBAR.setTitleColor(UIColor.white, for: .normal)
            btnMBAR.backgroundColor = UIColor.black
            btnMBAR.setTitleColor(UIColor.white, for: .normal)
            break
        default:
            break
        }
    }
    
    @IBAction func fDegreeButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.temperatureUnit != TemperatureUnit.F.rawValue {
            AppManager.currentUserSetting!.temperatureUnit = TemperatureUnit.F.rawValue
            self.setupTemperatureButtons(withTemperatureUnit: .F)
        }
    }
    @IBAction func cDegreeButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.temperatureUnit != TemperatureUnit.C.rawValue {
            AppManager.currentUserSetting!.temperatureUnit = TemperatureUnit.C.rawValue
            self.setupTemperatureButtons(withTemperatureUnit: .C)
        }
        
    }
    @IBAction func miButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.distanceInit != DistanceUnit.mi.rawValue {
            AppManager.currentUserSetting!.distanceInit = DistanceUnit.mi.rawValue
            self.setupDistanceButtons(withDistanceUnit: .mi)
        }
    }
    @IBAction func kmButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.distanceInit != DistanceUnit.km.rawValue {
            AppManager.currentUserSetting!.distanceInit = DistanceUnit.km.rawValue
            self.setupDistanceButtons(withDistanceUnit: .km)
        }
    }
    @IBAction func mphButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.speedUnit != SpeedUnit.mph.rawValue {
            AppManager.currentUserSetting!.speedUnit = SpeedUnit.mph.rawValue
            self.setupSpeedButtons(withSpeedUnit: .mph)
        }
    }
    @IBAction func kphButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.speedUnit != SpeedUnit.kph.rawValue {
            AppManager.currentUserSetting!.speedUnit = SpeedUnit.kph.rawValue
            self.setupSpeedButtons(withSpeedUnit: .kph)
        }
    }
    @IBAction func kmhButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.speedUnit != SpeedUnit.kmh.rawValue {
            AppManager.currentUserSetting!.speedUnit = SpeedUnit.kmh.rawValue
            self.setupSpeedButtons(withSpeedUnit: .kmh)
        }
    }
    @IBAction func msButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.speedUnit != SpeedUnit.ms.rawValue {
            AppManager.currentUserSetting!.speedUnit = SpeedUnit.ms.rawValue
            self.setupSpeedButtons(withSpeedUnit: .ms)
        }
    }
    @IBAction func mBarButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.pressureUnit != PressureUnit.mBar.rawValue {
            AppManager.currentUserSetting!.pressureUnit = PressureUnit.mBar.rawValue
            self.setupPressureButtons(withPressureUnit: .mBar)
        }
    }
    @IBAction func inHgButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.pressureUnit != PressureUnit.inHg.rawValue {
            AppManager.currentUserSetting!.pressureUnit = PressureUnit.inHg.rawValue
            self.setupPressureButtons(withPressureUnit: .inHg)
        }
    }
    @IBAction func psiButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.pressureUnit != PressureUnit.psi.rawValue {
            AppManager.currentUserSetting!.pressureUnit = PressureUnit.psi.rawValue
            self.setupPressureButtons(withPressureUnit: .psi)
        }
    }
    @IBAction func barButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.pressureUnit != PressureUnit.bar.rawValue {
            AppManager.currentUserSetting!.pressureUnit = PressureUnit.bar.rawValue
            self.setupPressureButtons(withPressureUnit: .bar)
        }
    }
    
    @IBAction func mmHgButtonTapped(_ sender: Any) {
        if AppManager.currentUserSetting!.pressureUnit != PressureUnit.mmHg.rawValue {
            AppManager.currentUserSetting!.pressureUnit = PressureUnit.mmHg.rawValue
            self.setupPressureButtons(withPressureUnit: .mmHg)
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.setupUnitCompleteCallBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
