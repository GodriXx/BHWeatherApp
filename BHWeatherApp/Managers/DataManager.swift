//
//  DataManager.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit
import CoreData

//DataManager class give access to weather local storage methods
class DataManager {
    
    static let shared = DataManager()
    
    private var managedContext: NSManagedObjectContext?
    
    private init() {
        //initialise managedContext
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
        
        let weatherMO = WeatherLocationMO(context: managedContext)
        let dayMO = DailyLocationMO(context: managedContext)
        
        weatherMO.cityName = weatherModel.cityName
        weatherMO.citySubtitle = weatherModel.citySubtitle
        weatherMO.latitude = weatherModel.latitude
        weatherMO.longitude = weatherModel.longitude
        weatherMO.currentTime = weatherModel.currentTime
        weatherMO.temperature = weatherModel.temperature ?? 0.0
        weatherMO.icon = weatherModel.icon
        weatherMO.sunsetTime = weatherModel.sunsetTime
        weatherMO.sunriseTime = weatherModel.sunriseTime
        weatherMO.humidity = Int16(weatherModel.humidity ?? 0)
        weatherMO.windSpeed = weatherModel.windSpeed ?? 0.0
        weatherMO.desc = weatherModel.description
        
        if let days = weatherModel.days {
            for day in days {
                dayMO.dayName = day.dayName
                dayMO.icon = day.icon
                dayMO.feelsLike = day.feelsLike ?? 0.0
                dayMO.max = day.max ?? 0.0
                dayMO.min = day.min ?? 0.0
                weatherMO.addToDays(dayMO)
            }
        }
        
        do {
            try managedContext.save()
            //handle response
            onCompletion(true)
        } catch _ as NSError {
            //handle response
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
            let weatherMO = weatherLocations as? [WeatherLocationMO] ??  []
            return getWeatherModels(weatherLocations: weatherMO)
        } catch _ as NSError {
            return []
        }
    }
    
    //adapt [WeatherLocationMO] to [WeatherModel]
    func getWeatherModels(weatherLocations: [WeatherLocationMO]) -> [WeatherModel] {
        return weatherLocations.map { (weatherLocation) -> WeatherModel in
            return WeatherModel(weatherLocation: weatherLocation)
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
    
    //update data
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
            guard let weatherMO = results[0] as? WeatherLocationMO else {
                onCompletion(false)
                return
            }
            weatherMO.cityName = weatherModel.cityName
            weatherMO.citySubtitle = weatherModel.citySubtitle
            weatherMO.latitude = weatherModel.latitude
            weatherMO.longitude = weatherModel.longitude
            weatherMO.currentTime = weatherModel.currentTime
            weatherMO.temperature = weatherModel.temperature ?? 0.0
            weatherMO.icon = weatherModel.icon
            weatherMO.sunsetTime = weatherModel.sunsetTime
            weatherMO.sunriseTime = weatherModel.sunriseTime
            weatherMO.humidity = Int16(weatherModel.humidity ?? 0)
            weatherMO.windSpeed = weatherModel.windSpeed ?? 0.0
            weatherMO.desc = weatherModel.description
        
            if let daysMO = weatherMO.days, daysMO.count > 0 {
                weatherMO.removeFromDays(daysMO)
            }
            
            if let days = weatherModel.days {
             
                for day in days {
                    let dayMO = DailyLocationMO(context: managedContext)
                    dayMO.dayName = day.dayName
                    dayMO.icon = day.icon
                    dayMO.feelsLike = day.feelsLike ?? 0.0
                    dayMO.max = day.max ?? 0.0
                    dayMO.min = day.min ?? 0.0
                    weatherMO.addToDays(dayMO)
                }
            }
            
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
