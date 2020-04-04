//
//  UserSettingStore+CoreDataProperties.swift
//  TodayWeather
//
//  Created by Dao Thanh Hai on 3/26/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension UserSettingStore {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettingStore> {
        return NSFetchRequest<UserSettingStore>(entityName: "UserSettingStore")
    }
    
    @NSManaged public var dataSource: String?
    @NSManaged public var distanceInit: String?
    @NSManaged public var iconSetIndex: Int64
    @NSManaged public var id: Int64
    @NSManaged public var isEnabledDailyNotification: Bool
    @NSManaged public var isEnabledPicture: Bool
    @NSManaged public var isEnabledRainSnowAlarm: Bool
    @NSManaged public var isEnabledSevereAlert: Bool
    @NSManaged public var language: String?
    @NSManaged public var pressureUnit: String?
    @NSManaged public var speedUnit: String?
    @NSManaged public var temperatureUnit: String?
    @NSManaged public var timeNotification: Date?
    @NSManaged public var userName: String?
    
}
class UserSettingStoreManager {
    func getDefaultDate() -> Date {
        let defautDate = Calendar.current.date(bySettingHour: 8, minute: 00, second: 00, of: Date())
        return defautDate!
    }
    func getUserSetting(byId id:Int64) -> UserSetting {        
        var userSetting = UserSetting(id: 1, isEnabledPicture: true, iconSetIndex: 1, temperatureUnit: TemperatureUnit.C.rawValue, distanceInit: DistanceUnit.km.rawValue, speedUnit: SpeedUnit.kmh.rawValue, pressureUnit: PressureUnit.mBar.rawValue, isEnabledDailyNotification: true, timeNotification: self.getDefaultDate(), isEnabledSevereAlert: true, isEnabledRainSnowAlarm: true, dataSource: DataSource.weatherbit.rawValue, userName: "", language: Language.english.rawValue)
        
        let managedObjectContext = AppDelegate.persistentContainer.viewContext
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserSettingStore",
                                       in: managedObjectContext)
        
        
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        let pred = NSPredicate(format: "(id = '\(id)')")
        request.predicate = pred
        do {
            let results = try managedObjectContext.fetch(request)
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                userSetting = UserSetting(id: match.value(forKey: "id") as? Int64 ?? 1, isEnabledPicture: match.value(forKey: "isEnabledPicture") as? Bool ?? true, iconSetIndex: match.value(forKey: "iconSetIndex") as? Int64 ?? 1, temperatureUnit: match.value(forKey: "temperatureUnit") as! String, distanceInit: match.value(forKey: "distanceInit") as! String, speedUnit: match.value(forKey: "speedUnit") as! String, pressureUnit: match.value(forKey: "pressureUnit") as! String, isEnabledDailyNotification: match.value(forKey: "isEnabledDailyNotification") as? Bool ?? true, timeNotification: match.value(forKey: "timeNotification") as? Date ?? Date(), isEnabledSevereAlert: match.value(forKey: "isEnabledSevereAlert") as? Bool ?? true, isEnabledRainSnowAlarm: match.value(forKey: "isEnabledRainSnowAlarm") as? Bool ?? true, dataSource: match.value(forKey: "dataSource") as! String, userName: match.value(forKey: "userName") as! String, language: match.value(forKey: "language") as! String)
            }
        } catch let error as NSError {
            print("\(error)")
        }
        return userSetting
    }
    func updateUserSetting(userSetting:UserSetting) {

        let managedObjectContext = AppDelegate.persistentContainer.viewContext
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserSettingStore",
                                       in: managedObjectContext)
        
        
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        let pred = NSPredicate(format: "(id = '\(userSetting.id)')")
        request.predicate = pred
        do {
            let results = try managedObjectContext.fetch(request)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                //found object, update
                match.setValue(userSetting.isEnabledPicture, forKey: "isEnabledPicture")
                match.setValue(userSetting.iconSetIndex, forKey: "iconSetIndex")
                match.setValue(userSetting.isEnabledRainSnowAlarm, forKey: "isEnabledRainSnowAlarm")
                match.setValue(userSetting.language, forKey: "language")
                match.setValue(userSetting.userName, forKey: "userName")
                match.setValue(userSetting.dataSource, forKey: "dataSource")
                match.setValue(userSetting.isEnabledSevereAlert, forKey: "isEnabledSevereAlert")
                match.setValue(userSetting.timeNotification, forKey: "timeNotification")
                match.setValue(userSetting.isEnabledDailyNotification, forKey: "isEnabledDailyNotification")
                match.setValue(userSetting.pressureUnit, forKey: "pressureUnit")
                match.setValue(userSetting.speedUnit, forKey: "speedUnit")
                match.setValue(userSetting.distanceInit, forKey: "distanceInit")
                match.setValue(userSetting.temperatureUnit, forKey: "temperatureUnit")
            } else {
                // not found, save new object
                let userSettingStore = UserSettingStore(entity: entityDescription!, insertInto: managedObjectContext)
                userSettingStore.id = userSetting.id
                userSettingStore.isEnabledPicture = userSetting.isEnabledPicture
                userSettingStore.iconSetIndex  = userSetting.iconSetIndex
                userSettingStore.isEnabledRainSnowAlarm = userSetting.isEnabledRainSnowAlarm
                userSettingStore.language  = userSetting.language
                userSettingStore.userName = userSetting.userName
                userSettingStore.dataSource  = userSetting.dataSource
                userSettingStore.isEnabledSevereAlert = userSetting.isEnabledSevereAlert
                userSettingStore.timeNotification  = userSetting.timeNotification
                userSettingStore.isEnabledDailyNotification = userSetting.isEnabledDailyNotification
                userSettingStore.pressureUnit  = userSetting.pressureUnit
                userSettingStore.speedUnit = userSetting.speedUnit
                userSettingStore.distanceInit  = userSetting.distanceInit
                userSettingStore.temperatureUnit = userSetting.temperatureUnit
            }
        } catch let error as NSError {
            print("\(error)")
        }
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
