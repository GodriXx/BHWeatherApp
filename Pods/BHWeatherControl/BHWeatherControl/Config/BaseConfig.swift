//
//  BaseConfig.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

struct BaseConfig {
    
    //get appID (OpenWeatherMap token) from info.plist in client app
    static var appID: String? {
        if let path = Bundle.main.path(forResource: "Info",
                                       ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            let value = dict["appID"] as? String
            return value
        }
        return nil
    }
    
    static let excludeWeatherDetails = "minutely,hourly,alert"
    static let excludeCurrentWeather = excludeWeatherDetails + ",daily"
    
}
