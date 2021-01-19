//
//  DailyWrapper.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

public struct DailyWrapper {
    
    public var dailyDate: Int?
    public var sunrise: Int?
    public var sunset: Int?
    public var day: Double?
    public var min: Double?
    public var max: Double?
    public var night: Double?
    public var eve: Double?
    public var morn: Double?
    public var feelsLike: Double?
    public var pressure: Int?
    public var humidity: Int?
    public var windSpeed: Double?
    public var status: String?
    public var description: String?
    public var icon: String?
    public var uvi: Double?
    public var timezoneOffset: Int?
    
    init(daily: Daily) {
        self.dailyDate = daily.dailyDt
        self.sunrise = daily.sunrise
        self.sunset = daily.sunset
        if let temp = daily.temp {
            self.day = temp.day
            self.min = temp.min
            self.max = temp.max
            self.night = temp.night
            self.eve = temp.eve
            self.morn = temp.morn
        }
        if let feels = daily.feelsLike {
            self.feelsLike = feels.day
        }
        self.pressure = daily.pressure
        self.humidity = daily.humidity
        self.windSpeed = daily.windSpeed
        if let weather = daily.weather,
           let weatherFirst = weather.first {
            self.icon = weatherFirst.icon
            self.status = weatherFirst.main
            self.description = weatherFirst.description
        }
        self.uvi = daily.uvi
    }
    
    public var image: UIImage? {
        return UIImage(named: self.icon ?? "")
    }
    
    public var dayName: String {
        let date = Date(dateInt: self.dailyDate ?? 0)
        return date.dayNameFromTimezone
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
