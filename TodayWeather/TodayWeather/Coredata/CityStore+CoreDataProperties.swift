//
//  CityStore+CoreDataProperties.swift
//  TodayWeather
//
//  Created by Đào Thanh Hải on 4/4/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON


extension CityStore {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityStore> {
        return NSFetchRequest<CityStore>(entityName: "CityStore")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var lon: Float
    @NSManaged public var lat: Float
    @NSManaged public var coutry_name: String?
    @NSManaged public var coutry_code: String?
    @NSManaged public var state_code: String?
    @NSManaged public var name: String?
    
}
var count = 0
class CityStoreManager {
    
    static func saveCityData(city:City) {
        
        let managedObjectContext = AppDelegate.persistentContainer.viewContext
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "CityStore",
                                       in: managedObjectContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(id = '\(city.id)')")
        request.predicate = pred
        do {
            let results = try managedObjectContext.fetch(request)
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                match.setValue(city.id, forKey: "id")
                match.setValue(city.lon, forKey: "lon")
                match.setValue(city.lat, forKey: "lat")
                match.setValue(city.coutry_name, forKey: "coutry_name")
                match.setValue(city.coutry_code, forKey: "coutry_code")
                match.setValue(city.state_code, forKey: "state_code")
                match.setValue(city.name, forKey: "name")
            } else {
                let cityStore = CityStore(entity: entityDescription!, insertInto: managedObjectContext)
                cityStore.id = city.id
                cityStore.lon = city.lon
                cityStore.lat = city.lat
                cityStore.coutry_name = city.coutry_name
                cityStore.coutry_code = city.coutry_code
                cityStore.state_code = city.state_code
                cityStore.name = city.name
                
            }
            try managedObjectContext.save()
            count += 1
            print("count: \(count)")
            
        } catch let error as NSError {
            print("\(error)")
        }
        
    }
    
    func getCityById(id:Int64) -> City {
        let managedObjectContext = AppDelegate.persistentContainer.viewContext
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "CityStore",
                                       in: managedObjectContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        let pred = NSPredicate(format: "(id = '\(id)')")
        request.predicate = pred
        do {
            let results = try managedObjectContext.fetch(request)
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                return City(id: match.value(forKey: "id") as! Int64, lon: match.value(forKey: "lon") as! Float, lat: match.value(forKey: "lat") as! Float, coutry_name: match.value(forKey: "coutry_name") as? String, coutry_code: match.value(forKey: "coutry_code") as? String, state_code: match.value(forKey: "state_code") as? String, name: match.value(forKey: "name") as? String)
            }
        } catch let error as NSError {
            print("\(error)")
        }
        return City(id: 0, lon: 0, lat: 0, coutry_name: "", coutry_code: "", state_code: "", name: "")
    }
    
    func getCities() -> [City] {
        var cities:[City] = []
        let managedObjectContext = AppDelegate.persistentContainer.viewContext
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "CityStore",
                                       in: managedObjectContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        do {
            let results = try managedObjectContext.fetch(request)
            
            if results.count > 0 {
                for result in results {
                    let match = result as! NSManagedObject
                    let city = City(id: match.value(forKey: "id") as! Int64, lon: match.value(forKey: "lon") as! Float, lat: match.value(forKey: "lat") as! Float, coutry_name: match.value(forKey: "coutry_name") as? String, coutry_code: match.value(forKey: "coutry_code") as? String, state_code: match.value(forKey: "state_code") as? String, name: match.value(forKey: "name") as? String)
                    if !cities.contains(where: {$0.id == city.id}){
                        cities.append(city)
                    }
                }
            }
            
        } catch let error as NSError {
            print("\(error)")
        }
        return cities
    }
}

struct City {
    var id: Int64
    var lon: Float
    var lat: Float
    var coutry_name: String?
    var coutry_code: String?
    var state_code: String?
    var name: String?
}


