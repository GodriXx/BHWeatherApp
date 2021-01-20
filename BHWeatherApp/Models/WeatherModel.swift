//
//  WeatherModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit
import MapKit
import BHWeatherControl

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
    var image: UIImage? {
        return UIImage(named: self.icon ?? "")
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
        //self.days = weather.days
        self.currentTime = weather.currentTime
    }
    
    func compareLocation(lon: String, lat: String) -> Bool {
        let lon1 = String(format: "%.2f", ((self.longitude ?? "") as NSString).doubleValue)
        let lat1 = String(format: "%.2f", ((self.latitude ?? "") as NSString).doubleValue)
        
        let lon2 = String(format: "%.2f", (lon as NSString).doubleValue)
        let lat2 = String(format: "%.2f", (lat as NSString).doubleValue)
        
        return (lon1 == lon2) && (lat1 == lat2)
    }
}
