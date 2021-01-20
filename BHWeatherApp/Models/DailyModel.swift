//
//  DailyModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

struct DailyModel {
    
    var dailyDate: Int?
    var sunrise: Int?
    var sunset: Int?
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
    var feelsLike: Double?
    var pressure: Int?
    var humidity: Int?
    var windSpeed: Double?
    var status: String?
    var description: String?
    var icon: String?
    var uvi: Double?
    var timezoneOffset: Int?
    var dayName: String
    var sunriseTime: String
    var sunsetTime: String
    
    var image: UIImage? {
        return UIImage(named: self.icon ?? "")
    }

}
