//
//  WeatherWrapper.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

// WeatherWrapper is a simple object created from WeatherObject
public struct WeatherWrapper {
    
    public var longitude: String?
    public var latitude: String?
    public var timezoneName: String?
    public var timezoneOffset: Int?
    public var dayDate: Int?
    public var sunrise: Int?
    public var sunset: Int?
    public var temperature: Double?
    public var feelsLike: Double?
    public var pressure: Double?
    public var humidity: Int?
    public var uvi: Double?
    public var visibility: Int?
    public var windSpeed: Double?
    public var windDeg: Int?
    public var status: String?
    public var description: String?
    public var icon: String?
    public var days: [DailyWrapper]?
    
    init(weatherObject: WeatherObject) {
        self.longitude = String(weatherObject.lon ?? 0.0)
        self.latitude = String(weatherObject.lat ?? 0.0)
        self.timezoneName = weatherObject.timezone
        self.timezoneOffset = weatherObject.timezoneOffset
        if let current = weatherObject.current {
            self.dayDate = current.dayDt
            self.sunrise = current.sunrise
            self.sunset = current.sunset
            self.temperature = current.temp
            self.feelsLike = current.feelsLike
            self.pressure = current.pressure
            self.humidity = current.humidity
            self.uvi = current.uvi
            self.visibility = current.visibility
            self.windSpeed = current.windSpeed
            self.windDeg = current.windDeg
            if let weather = current.weather,
               let weatherFirst = weather.first {
                self.icon = weatherFirst.icon
                self.status = weatherFirst.main
                self.description = weatherFirst.description
            }
        }
        guard let weatherDays = weatherObject.daily else { return }
        self.days = weatherDays.map({ (daily) -> DailyWrapper in
            return daily.getDailyWrapper(timezoneOffset: self.timezoneOffset ?? 0)
        })
    }
    
}

extension WeatherWrapper {
    
    public var image: UIImage? {
        return UIImage(named: self.icon ?? "")
    }
    
    public var currentTime: String? {
        return Date().getCurrentTime(timezoneOffset: self.timezoneOffset ?? 0)
    }
    
    public var sunriseTime: String {
        let date = Date(dateInt: self.sunrise ?? 0)
        return date.getCurrentTime(timezoneOffset: self.timezoneOffset ?? 0)
    }
    
    public var sunsetTime: String {
        let date = Date(dateInt: self.sunset ?? 0)
        return date.getCurrentTime(timezoneOffset: self.timezoneOffset ?? 0)
    }
    
}
