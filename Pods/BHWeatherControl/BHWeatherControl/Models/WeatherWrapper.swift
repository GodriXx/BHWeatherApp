//
//  WeatherWrapper.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

public struct WeatherWrapper {
    
    public var timezoneName: String?
    public var timezoneOffset: Int?
    public var temperature: Double?
    public var status: String?
    public var description: String?
    public var icon: String?
    public var days: [DailyWrapper]?
    
    init(weatherObject: WeatherObject) {
        self.timezoneName = weatherObject.timezone
        self.timezoneOffset = weatherObject.timezoneOffset
        if let current = weatherObject.current {
            self.temperature = current.temp
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
    
    public var image: UIImage? {
        return UIImage(named: self.icon ?? "")
    }
    
    public var currentTime: String? {
        return Date().getCurrentTime(timezoneOffset: self.timezoneOffset ?? 0)
    }
    
}
