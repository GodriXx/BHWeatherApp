//
//  WeatherModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit
import MapKit
import BHWeatherControl
import CoreData

class WeatherModel {
    
    var cityName: String?
    var citySubtitle: String?
    var longitude: String?
    var latitude: String?
    var timezoneName: String?
    var timezoneOffset: Int?
    var temperature: Double?
    var status: String?
    var description: String?
    var icon: String?
    var days: [DailyModel]?
    var currentTime: String?
    var dayDate: Int?
    var feelsLike: Double?
    var pressure: Double?
    var humidity: Int?
    var uvi: Double?
    var visibility: Int?
    var windSpeed: Double?
    var windDeg: Int?
    var sunriseTime: String?
    var sunsetTime: String?
    
    var image: UIImage? {
        return UIImage(named: self.icon ?? "")
    }
    
    var temperatureStr: String {
        guard let temperature = self.temperature else { return "" }
        return String(format: "%.0f", round(temperature)) + BHText.general_temp.value
    }
    
    init(cityName: String? = "", citySubtitle: String? = "", coordinate: CLLocationCoordinate2D) {
        self.cityName = cityName
        self.longitude = String(coordinate.longitude)
        self.latitude = String(coordinate.latitude)
    }
    
    init(cityName: String? = "", citySubtitle: String? = "", longitude: String? = "", latitude: String? = "") {
        self.cityName = cityName
        self.longitude = longitude
        self.latitude = latitude
    }
    
    func updateDataFrom(weather: WeatherWrapper) {
        
        self.timezoneName = weather.timezoneName
        self.timezoneOffset = weather.timezoneOffset
        self.temperature = weather.temperature
        self.status = weather.status
        self.description = weather.description
        self.icon = weather.icon
        self.currentTime = weather.currentTime
        
        self.dayDate = weather.dayDate
        self.feelsLike = weather.feelsLike
        self.pressure = weather.pressure
        self.humidity = weather.humidity
        self.uvi = weather.uvi
        self.visibility = weather.visibility
        self.windSpeed = weather.windSpeed
        self.windDeg = weather.windDeg
        self.sunriseTime = weather.sunriseTime
        self.sunsetTime = weather.sunsetTime
        
        guard let weatherDays = weather.days else { return }
        self.days = weatherDays.map({ (dailyWrapper) -> DailyModel in
            return DailyModel(min: dailyWrapper.min,
                              max: dailyWrapper.max,
                              dayName: dailyWrapper.dayName,
                              icon: dailyWrapper.icon,
                              feelsLike: dailyWrapper.feelsLike)
        })
        
    }
    
    func compareLocation(lon: String, lat: String) -> Bool {
        let lon1 = String(format: "%.2f", ((self.longitude ?? "") as NSString).doubleValue)
        let lat1 = String(format: "%.2f", ((self.latitude ?? "") as NSString).doubleValue)
        
        let lon2 = String(format: "%.2f", (lon as NSString).doubleValue)
        let lat2 = String(format: "%.2f", (lat as NSString).doubleValue)
        
        return (lon1 == lon2) && (lat1 == lat2)
    }
    
    init(dbObject: NSManagedObject) {
        self.temperature = dbObject.value(forKeyPath: "temperature") as? Double
        self.icon = dbObject.value(forKeyPath: "icon") as? String
        self.currentTime = dbObject.value(forKeyPath: "currentTime") as? String
        self.citySubtitle = dbObject.value(forKeyPath: "citySubtitle") as? String
        self.cityName = dbObject.value(forKeyPath: "cityName") as? String
        self.latitude = dbObject.value(forKeyPath: "latitude") as? String
        self.longitude = dbObject.value(forKeyPath: "longitude") as? String
    }
    
}
