//
//  WeatherCollectionViewCell.swift
//  TodayWeather
//
//  Created by Tuan Vu on 4/12/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import Charts
import CoreLocation

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var currentTemLabel: UILabel!
    @IBOutlet weak var maxTemLabel: UILabel!
    @IBOutlet weak var minTemLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDesLabel: UILabel!
    @IBOutlet weak var hourlyWeatherCLV: UICollectionView!
    
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var dewPointLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    // next 7 day temp begin
    @IBOutlet weak var maxTempCurrentLabel: UILabel!
    @IBOutlet weak var minTempCurrentLabel: UILabel!
    @IBOutlet weak var currentDayTop: NSLayoutConstraint!
    @IBOutlet weak var currentDayBottom: NSLayoutConstraint!
    
    @IBOutlet weak var maxTempOneDayLabel: UILabel!
    @IBOutlet weak var minTempOneDayLabel: UILabel!
    @IBOutlet weak var oneDayAgoTop: NSLayoutConstraint!
    @IBOutlet weak var oneDayAgoBottom: NSLayoutConstraint!
    
    @IBOutlet weak var maxTempTwoDaysLabel: UILabel!
    @IBOutlet weak var minTempTwoDaysLabel: UILabel!
    @IBOutlet weak var twoDaysAgoTop: NSLayoutConstraint!
    @IBOutlet weak var twoDaysAgoBottom: NSLayoutConstraint!
    
    @IBOutlet weak var maxTempThreeDaysLabel: UILabel!
    @IBOutlet weak var minTempThreeDaysLabel: UILabel!
    @IBOutlet weak var threeDaysAgoTop: NSLayoutConstraint!
    @IBOutlet weak var threeDaysAgoBottom: NSLayoutConstraint!
    
    @IBOutlet weak var maxTempFourDaysLabel: UILabel!
    @IBOutlet weak var minTempFourDaysLabel: UILabel!
    @IBOutlet weak var fourDaysAgoTop: NSLayoutConstraint!
    @IBOutlet weak var fourDaysAgoBottom: NSLayoutConstraint!
    
    @IBOutlet weak var maxTempFiveDaysLabel: UILabel!
    @IBOutlet weak var minTempFiveDaysLabel: UILabel!
    @IBOutlet weak var fiveDaysAgoTop: NSLayoutConstraint!
    @IBOutlet weak var fiveDaysAgoBottom: NSLayoutConstraint!
    
    @IBOutlet weak var maxTempSixDaysLabel: UILabel!
    @IBOutlet weak var minTempSixDaysLabel: UILabel!
    @IBOutlet weak var sixDaysAgoTop: NSLayoutConstraint!
    @IBOutlet weak var sixDaysAgoBottom: NSLayoutConstraint!
    // next 7 day temp end
    
    // next 7 days weather begin
    @IBOutlet weak var todayRainRateLabel: UILabel!
    @IBOutlet weak var todayDayLabel: UILabel!
    @IBOutlet weak var todayWeatherLabel: UIImageView!
    
    @IBOutlet weak var oneDayAgoRainRateLabel: UILabel!
    @IBOutlet weak var oneDayAgoDayLabel: UILabel!
    @IBOutlet weak var oneDayAgoWeatherLabel: UIImageView!
    
    @IBOutlet weak var twoDaysAgoRainRateLabel: UILabel!
    @IBOutlet weak var twoDaysAgoDayLabel: UILabel!
    @IBOutlet weak var twoDaysAgoWeatherLabel: UIImageView!
    
    @IBOutlet weak var threeDaysAgoRainRateLabel: UILabel!
    @IBOutlet weak var threeDaysAgoDayLabel: UILabel!
    @IBOutlet weak var threeDaysAgoWeatherLabel: UIImageView!
    
    @IBOutlet weak var fourDaysAgoRainRateLabel: UILabel!
    @IBOutlet weak var fourDaysAgoDayLabel: UILabel!
    @IBOutlet weak var fourDaysAgoWeatherLabel: UIImageView!
    
    @IBOutlet weak var fiveDaysAgoRainRateLabel: UILabel!
    @IBOutlet weak var fiveDaysAgoDayLabel: UILabel!
    @IBOutlet weak var fiveDaysAgoWeatherLabel: UIImageView!
    
    @IBOutlet weak var sixDaysAgoRainRateLabel: UILabel!
    @IBOutlet weak var sixDaysAgoDayLabel: UILabel!
    @IBOutlet weak var sixDaysAgoWeatherLabel: UIImageView!
    // next 7 days weather end
    
    @IBOutlet weak var lineChart: LineChartView!
    
    //air quality
    
    @IBOutlet weak var aiqLabel: UILabel!
    @IBOutlet weak var aiqTitleLabel: UILabel!
    @IBOutlet weak var aiqDesLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sunSetView: SunView!

    @IBOutlet weak var windImageView: UIImageView!
    
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var gotoTenDaysDetail: ((WeatherCollectionViewCell) -> Swift.Void)?
    var goto24Hours: ((WeatherCollectionViewCell) -> Swift.Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        slider.setThumbImage(UIImage(named: "dot"), for: .normal)
        slider.setThumbImage(UIImage(named: "dot"), for: .highlighted)
        hourlyWeatherCLV.register(UINib(nibName: "HourlyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HourlyCollectionViewCell")
        hourlyWeatherCLV.dataSource = self
        hourlyWeatherCLV.delegate = self
        do {
            let gif = try UIImage(gifName: "wind.gif")
            windImageView.setGifImage(gif)
            windImageView.loopCount = -1
        } catch {
            print(error)
        }
        configChart()
    }
    
    func setData(_ current: CurrentWeatherDataModelElement) {
        thumbImageView.isHidden = !(AppManager.currentUserSetting?.isEnabledPicture ?? true)
        currentTemLabel.text = current.temp?.toTempString()
        currentTimeLabel.text = DateFormatter.string(from: Date(), format: DateFormat.EddMMM, timeZone: .current)
        cityLabel.text = current.cityName
        weatherLabel.text = current.weather?.weatherDescription
        weatherDesLabel.text = current.weatherDescription()
        feelLikeLabel.text = current.appTemp?.toTempNonSpaceString()
        humidityLabel.text = (current.rh?.toString() ?? "") + "%"
        uvLabel.text =  current.uv?.toString()
        visibilityLabel.text = (current.vis?.toString() ?? "") + " \(AppManager.currentUserSetting?.distanceInit ?? "km")"
        dewPointLabel.text = current.dewpt?.toTempNonSpaceString()
        pressureLabel.text = current.pres?.toString()
        hourlyWeatherCLV.reloadData()
        windSpeedLabel.text = "\(Int(current.windSpd ?? 0)) \(AppManager.currentUserSetting?.speedUnit ?? "km/h")"
        windDirectionLabel.text = current.windCdirFull
        setSunView(timezone: current.timezone!, sunset: current.sunset!, sunrise: current.sunrise!)
    }
    
    func setDaily(_ daily: DailyWeatherDataModelElement) {
        maxTemLabel.text = daily.maxTemp?.toTempString()
        minTemLabel.text = daily.minTemp?.toTempString()
    }
    
    func setSevenDays(days: [DailyWeatherDataModelElement]) {
        let maxTemp = days.sorted { (lef, rgh) -> Bool in
            return (lef.maxTemp ?? 0) > (rgh.maxTemp ?? 0)
            }.first?.appMaxTemp
        let minTemp = days.sorted { (lef, rgh) -> Bool in
            return (lef.minTemp ?? 0) < (rgh.minTemp ?? 0)
            }.first?.minTemp
        
        let today = days[0]
        maxTempCurrentLabel.text = today.maxTemp?.toTemp()
        minTempCurrentLabel.text = today.minTemp?.toTemp()
        currentDayTop.constant = CGFloat((maxTemp ?? 0) - (today.maxTemp ?? 0)) * 2
        currentDayBottom.constant = CGFloat((today.minTemp ?? 0) - (minTemp ?? 0)) * 2
        todayRainRateLabel.text = "\(today.pop ?? 0)%"
        todayRainRateLabel.isHidden = (today.pop ?? 0) <= 0
        todayDayLabel.text = DateFormatter.string(from: Date(), format: "E")
        todayWeatherLabel.image = UIImage(named: today.weather?.icon ?? "")
        
        let tomorow = days[1]
        maxTempOneDayLabel.text = tomorow.maxTemp?.toTemp()
        minTempOneDayLabel.text = tomorow.minTemp?.toTemp()
        oneDayAgoTop.constant = CGFloat((maxTemp ?? 0) - (tomorow.maxTemp ?? 0)) * 2
        oneDayAgoBottom.constant = CGFloat((tomorow.minTemp ?? 0) - (minTemp ?? 0)) * 2
        oneDayAgoRainRateLabel.text = "\(tomorow.pop ?? 0)*"
        oneDayAgoRainRateLabel.isHidden = (tomorow.pop ?? 0) <= 0
        if let tomorowDate = DateFormatter.date(from: tomorow.datetime ?? "", format: "yyyy-MM-dd") {
            oneDayAgoDayLabel.text = DateFormatter.string(from: tomorowDate, format: "E")
        }
        oneDayAgoWeatherLabel.image = UIImage(named: tomorow.weather?.icon ?? "")
        
        let next2Days = days[2]
        maxTempTwoDaysLabel.text = next2Days.maxTemp?.toTemp()
        minTempTwoDaysLabel.text = next2Days.minTemp?.toTemp()
        twoDaysAgoTop.constant = CGFloat((maxTemp ?? 0) - (next2Days.maxTemp ?? 0)) * 2
        twoDaysAgoBottom.constant = CGFloat((next2Days.minTemp ?? 0) - (minTemp ?? 0)) * 2
        twoDaysAgoRainRateLabel.text = "\(next2Days.pop ?? 0)%"
        twoDaysAgoRainRateLabel.isHidden = (next2Days.pop ?? 0) <= 0
        if let date = DateFormatter.date(from: next2Days.datetime ?? "", format: "yyyy-MM-dd") {
            twoDaysAgoDayLabel.text = DateFormatter.string(from: date, format: "E")
        }
        twoDaysAgoWeatherLabel.image = UIImage(named: next2Days.weather?.icon ?? "")
        
        let next3Days = days[3]
        maxTempThreeDaysLabel.text = next3Days.maxTemp?.toTemp()
        minTempThreeDaysLabel.text = next3Days.minTemp?.toTemp()
        threeDaysAgoTop.constant = CGFloat((maxTemp ?? 0) - (next3Days.maxTemp ?? 0)) * 2
        threeDaysAgoBottom.constant = CGFloat((next3Days.minTemp ?? 0) - (minTemp ?? 0)) * 2
        threeDaysAgoRainRateLabel.text = "\(next3Days.pop ?? 0)%"
        threeDaysAgoRainRateLabel.isHidden = (next3Days.pop ?? 0) <= 0
        if let date = DateFormatter.date(from: next3Days.datetime ?? "", format: "yyyy-MM-dd") {
            threeDaysAgoDayLabel.text = DateFormatter.string(from: date, format: "E")
        }
        threeDaysAgoWeatherLabel.image = UIImage(named: next3Days.weather?.icon ?? "")
        
        let next4Days = days[4]
        maxTempFourDaysLabel.text = next4Days.maxTemp?.toTemp()
        minTempFourDaysLabel.text = next4Days.minTemp?.toTemp()
        fourDaysAgoTop.constant = CGFloat((maxTemp ?? 0) - (next4Days.maxTemp ?? 0)) * 2
        fourDaysAgoBottom.constant = CGFloat((next4Days.minTemp ?? 0) - (minTemp ?? 0)) * 2
        fourDaysAgoRainRateLabel.text = "\(next4Days.pop ?? 0)%"
        fourDaysAgoRainRateLabel.isHidden = (next4Days.pop ?? 0) <= 0
        if let date = DateFormatter.date(from: next4Days.datetime ?? "", format: "yyyy-MM-dd") {
            fourDaysAgoDayLabel.text = DateFormatter.string(from: date, format: "E")
        }
        fourDaysAgoWeatherLabel.image = UIImage(named: next4Days.weather?.icon ?? "")
        
        let next5Days = days[5]
        maxTempFiveDaysLabel.text = next5Days.maxTemp?.toTemp()
        minTempFiveDaysLabel.text = next5Days.minTemp?.toTemp()
        fiveDaysAgoTop.constant = CGFloat((maxTemp ?? 0) - (next5Days.maxTemp ?? 0)) * 2
        fiveDaysAgoBottom.constant = CGFloat((next5Days.minTemp ?? 0) - (minTemp ?? 0)) * 2
        fiveDaysAgoRainRateLabel.text = "\(next5Days.pop ?? 0)%"
        fiveDaysAgoRainRateLabel.isHidden = (next5Days.pop ?? 0) <= 0
        if let date = DateFormatter.date(from: next5Days.datetime ?? "", format: "yyyy-MM-dd") {
            fiveDaysAgoDayLabel.text = DateFormatter.string(from: date, format: "E")
        }
        fiveDaysAgoWeatherLabel.image = UIImage(named: next5Days.weather?.icon ?? "")
        
        let next6Days = days[6]
        maxTempSixDaysLabel.text = next6Days.maxTemp?.toTemp()
        minTempSixDaysLabel.text = next6Days.minTemp?.toTemp()
        sixDaysAgoTop.constant = CGFloat((maxTemp ?? 0) - (next6Days.maxTemp ?? 0)) * 2
        sixDaysAgoBottom.constant = CGFloat((next6Days.minTemp ?? 0) - (minTemp ?? 0)) * 2
        sixDaysAgoRainRateLabel.text = "\(next6Days.pop ?? 0)%"
        sixDaysAgoRainRateLabel.isHidden = (next6Days.pop ?? 0) <= 0
        if let date = DateFormatter.date(from: next6Days.datetime ?? "", format: "yyyy-MM-dd") {
            sixDaysAgoDayLabel.text = DateFormatter.string(from: date, format: "E")
        }
        sixDaysAgoWeatherLabel.image = UIImage(named: next6Days.weather?.icon ?? "")
        self.contentView.layoutIfNeeded()
        
    }
    
    func setAirQuality(_ current: CurrentWeatherDataModelElement) {
        let aiq = AirQuality.getQuality(current.aqi ?? 0)
        aiqLabel.text = "\(current.aqi ?? 0)"
        aiqTitleLabel.text = aiq.getTitle()
        aiqDesLabel.text = aiq.getDescription()
        slider.value = Float(current.aqi ?? 0)
    }
    func setSunView(timezone:String,sunset:String,sunrise:String) {
        let timeZone = TimeZone(identifier: timezone)
        let sunTime = getSunTimeByTimeZone(timezone:timeZone!, sunset: sunset, sunrise: sunrise,now: Date().Date2String(format: "HH:mm"))
        sunSetView.stringFrom = sunTime.sunriseString
        sunSetView.stringTo = sunTime.sunsetString
        if sunTime.now <= sunTime.sunrise {
            sunSetView.percent = 0
        } else if sunTime.now >= sunTime.sunset {
            sunSetView.percent = 1
        } else {
            sunSetView.percent = CGFloat(sunTime.now.timeIntervalSince(sunTime.sunrise) / sunTime.sunset.timeIntervalSince(sunTime.sunrise))
        }
    }
    func getSunTimeByTimeZone(timezone:TimeZone,sunset:String,sunrise:String,now:String) -> SunTime{
        var sunTime = SunTime(sunrise: Date(), sunset: Date(), now: Date(),sunriseString: "",sunsetString: "")
        let dateformatter = DateFormatter()
        dateformatter.timeZone = TimeZone(abbreviation: "GMT")
        dateformatter.dateFormat = "HH:mm"
        sunTime.sunrise = (dateformatter.date(from: sunrise)?.add(component: .second, value: (timezone.secondsFromGMT())))!
        sunTime.sunset = (dateformatter.date(from: sunset)?.add(component: .second, value: (timezone.secondsFromGMT())).add(component: .day, value: 1))!
        var dateComponents = DateComponents()
        var calendar = Calendar.current
        calendar.timeZone = timezone
        dateComponents.hour = calendar.component(.hour, from: Date())
        dateComponents.minute = calendar.component(.minute, from: Date())
        dateComponents.year = calendar.component(.year, from: sunTime.sunrise)
        dateComponents.month = calendar.component(.month, from: sunTime.sunrise)
        dateComponents.day = calendar.component(.day, from: sunTime.sunrise)
        sunTime.now = (calendar.date(from: dateComponents)?.add(component: .second, value: timezone.secondsFromGMT()))!
        sunTime.sunsetString = dateformatter.string(from: sunTime.sunset)
        sunTime.sunriseString = dateformatter.string(from: sunTime.sunrise)
        return sunTime
    }
    
    @IBAction func gotoTenDays(_ sender: Any) {
        gotoTenDaysDetail?(self)
    }
    
}

extension WeatherCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell", for: indexPath)
        as! HourlyCollectionViewCell
        cell.boundView.isHidden = indexPath.row != 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goto24Hours?(self)
    }
}

extension WeatherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 120)
    }
}

extension WeatherCollectionViewCell {
        func configChart() {
            lineChart.chartDescription?.enabled = false
            lineChart.dragEnabled = false
            lineChart.setScaleEnabled(false)
            lineChart.pinchZoomEnabled = false
            lineChart.drawGridBackgroundEnabled = false
            lineChart.rightAxis.enabled = false
            lineChart.legend.form = .line
            lineChart.legend.enabled = false
            lineChart.highlightPerTapEnabled = false
            
            let leftAxis = lineChart.leftAxis
            leftAxis.removeAllLimitLines()
            leftAxis.axisMaximum = 100
            leftAxis.axisMinimum = 0
            leftAxis.labelTextColor = .white
            leftAxis.labelFont = .systemFont(ofSize: 14)
            leftAxis.drawGridLinesEnabled = false
            
            let xAxis = lineChart.xAxis
            xAxis.labelTextColor = UIColor(hexString: "8C8C8C")
            xAxis.labelFont = .systemFont(ofSize: 14)
            xAxis.drawGridLinesEnabled = false
            xAxis.labelPosition = .bottom
            updateChartData()            
        }
        
        func updateChartData() {
            self.setDataCount(10, range: UInt32(40))
        }
        
    
    func setDataCount(_ count: Int, range: UInt32) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "r04d"))
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        set1.setColor(.white)
        set1.setCircleColor(.white)
        set1.lineWidth = 0
        set1.circleRadius = 0
        set1.drawValuesEnabled = false
        set1.drawCircleHoleEnabled = true
        
        set1.fillAlpha = 1
        set1.fill = Fill(color: UIColor(hexString: "5A96F2"))
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        lineChart.data = data
    }
}
struct SunTime {
    var sunrise:Date
    var sunset:Date
    var now:Date
    var sunriseString:String
    var sunsetString:String
    
}
enum AirQuality {
    case good
    case moderate
    case unhealthyForSensitiveGroups
    case unhealthy
    case veryUnhealthy
    case hazardous
    
    static func getQuality(_ aiq: Int) -> AirQuality {
        if aiq <= 50 {
            return .good
        } else if 50 < aiq && aiq <= 100 {
            return .moderate
        } else if 101 < aiq && aiq <= 150 {
            return .unhealthyForSensitiveGroups
        } else if 151 < aiq && aiq <= 200 {
            return .unhealthy
        } else if 201 < aiq && aiq <= 300 {
            return .veryUnhealthy
        } else {
            return .hazardous
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .good:
            return "Good"
        case .moderate:
            return "Moderate"
        case .unhealthyForSensitiveGroups:
            return "Unhealthy for Sensitive Groups"
        case .unhealthy:
            return "Unhealthy"
        case .veryUnhealthy:
            return "Very Unhealthy"
        case .hazardous:
            return "Hazardous"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .good:
            return "Air quality is considered satisfactory, and air pollution poses little or no risk"
        case .moderate:
            return "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution"
        case .unhealthyForSensitiveGroups:
            return "Members of sensitive groups may experience health effects. The general public is not likely to be affected."
        case .unhealthy:
            return "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects."
        case .veryUnhealthy:
            return "Health warnings of emergency conditions. The entire population is more likely to be affected."
        case .hazardous:
            return "Health alert: everyone may experience more serious health effects."
        }
    }
}
