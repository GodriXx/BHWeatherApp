//
//  DataManager.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    private var managedContext: NSManagedObjectContext?
    
    private init() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Save Data
    func saveWeatherLocation(weatherModel: WeatherModel,
                             onCompletion: @escaping(Bool) -> Void) {
        
        guard let managedContext = self.managedContext else { return }
        let entity =
            NSEntityDescription.entity(forEntityName: "WeatherLocation",
                                       in: managedContext)!
        
        let location = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
        
        location.setValue(weatherModel.cityName, forKeyPath: "cityName")
        location.setValue(weatherModel.citySubtitle, forKeyPath: "citySubtitle")
        location.setValue(weatherModel.latitude, forKeyPath: "latitude")
        location.setValue(weatherModel.longitude, forKeyPath: "longitude")
        location.setValue(weatherModel.currentTime, forKeyPath: "currentTime")
        location.setValue(weatherModel.temperature, forKeyPath: "temperature")
        location.setValue(weatherModel.icon, forKeyPath: "icon")
        
        do {
            try managedContext.save()
            onCompletion(true)
        } catch _ as NSError {
            onCompletion(false)
        }
    }
    
    //get Datas
    func getWeatherLocation() -> [WeatherModel] {
        guard let managedContext = self.managedContext else { return [] }
        
        var weatherLocations: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WeatherLocation")
        do {
            weatherLocations = try managedContext.fetch(fetchRequest)
            return getWeatherModels(weatherLocations: weatherLocations)
        } catch _ as NSError {
            return []
        }
    }
    
    func getWeatherModels(weatherLocations: [NSManagedObject]) -> [WeatherModel] {
        return weatherLocations.map { (weatherLocation) -> WeatherModel in
            return WeatherModel(dbObject: weatherLocation)
        }
    }
    
    //fetch Data if exist
    func isWeatherExist(cityName: String) -> Bool {
        guard let managedContext = self.managedContext else { return false }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherLocation")
        fetchRequest.predicate = NSPredicate(format: "cityName = %@", cityName as CVarArg)
        
        var entitiesCount = 0
        
        do {
            entitiesCount = try managedContext.count(for: fetchRequest)
            return entitiesCount > 0
        }
        catch {
            return false
        }
    }
    
    
    //remove Data
    func removeWeatherLocation(weatherModel: WeatherModel,
                               onCompletion: @escaping(Bool) -> Void) {
        guard let managedContext = self.managedContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherLocation")
        fetchRequest.predicate = NSPredicate(format: "cityName = %@", (weatherModel.cityName ?? "") as CVarArg)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = result[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
                onCompletion(true)
            }
            catch {
                onCompletion(false)
            }
            
        }
        catch {
            onCompletion(false)
        }
    }
    
    func updateWeather(weatherModel: WeatherModel,
                       onCompletion: @escaping(Bool) -> Void) {
        
        guard let managedContext = self.managedContext else { return }
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "WeatherLocation")
        
        let predicate = NSPredicate(format: "cityName = %@", (weatherModel.cityName ?? ""))
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            // begin update
            let managedObject = results[0]
            managedObject.setValue(weatherModel.citySubtitle, forKeyPath: "citySubtitle")
            managedObject.setValue(weatherModel.currentTime, forKeyPath: "currentTime")
            managedObject.setValue(weatherModel.temperature, forKeyPath: "temperature")
            managedObject.setValue(weatherModel.icon, forKeyPath: "icon")
            do {
                try managedContext.save()
                onCompletion(true)
            }
            catch {
                onCompletion(false)
            }
            
        } catch _ as NSError {
            onCompletion(false)
        }
        //end update
    }
    
    
}
