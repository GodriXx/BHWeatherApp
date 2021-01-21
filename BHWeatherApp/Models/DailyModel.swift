//
//  DailyModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit
import BHWeatherControl

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
    var dayName: String?
    var sunriseTime: String?
    var sunsetTime: String?
    
    var feelsLikeStr: String {
        guard let feelsLike = self.feelsLike else { return "" }
        return String(format: "%.0f", round(feelsLike)) + BHText.general_temp.value
    }
    
    var minStr: String {
        guard let min = self.min else { return "" }
        return String(format: "%.0f", round(min)) + BHText.general_temp.value
    }
    
    var maxStr: String {
        guard let max = self.max else { return "" }
        return String(format: "%.0f", round(max)) + BHText.general_temp.value
    }
    
    var image: UIImage? {
        return UIImage(named: self.icon ?? "")
    }
    
    init(min: Double?, max: Double?, dayName: String, icon: String?, feelsLike: Double?) {
        self.min = min
        self.max = max
        self.icon = icon
        self.dayName = dayName
        self.feelsLike = feelsLike
    }
    
}
