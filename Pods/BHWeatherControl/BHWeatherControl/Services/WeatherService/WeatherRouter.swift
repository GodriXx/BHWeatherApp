//
//  WeatherRouter.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

/**
 
 WeatherRequestType.
 
 - Author: Bassem Hatira
 
 - Note: WeatherRequestType define the specific weather requests
 
 */
enum WeatherRequestType {
    case getCurrentWeather(location: Location, unit: Unit = .metric)
    case getWeatherDetails(location: Location, unit: Unit = .metric)
    
    var endPoint: String {
        switch self {
        case .getCurrentWeather(let location, let unit), .getWeatherDetails(let location, let unit):
            // static AppID used for Unit test issue, else, the API will use client's appID
            let appId = NSClassFromString("XCTest") != nil ? "f7d0c120d2e9b87eb0fb2b30cf4a5ce3" : "\(BaseConfig.appID ?? "")"
            return "onecall?lat=\(location.lat)&lon=\(location.lon)&exclude=\(self.exclude )&units=\(unit.rawValue)&lang=\(Constants.appLang)&appid=\(appId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentWeather, .getWeatherDetails:
            return .get
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .getCurrentWeather, .getWeatherDetails:
            return nil
        }
    }
    
    var exclude: String {
        switch self {
        case .getCurrentWeather:
            return BaseConfig.excludeCurrentWeather
        case .getWeatherDetails:
            return BaseConfig.excludeWeatherDetails
        }
    }
}

/**
 
 WeatherRouter.
 
 - Author: Bassem Hatira
 
 - Note: WeatherRouter used to define the specifications necessary for a weather request
 
 */
class WeatherRouter: RouterType {
    
    var headers: [String: String]?
    
    var type: WeatherRequestType = .getCurrentWeather(location: Location(lat: "", lon: ""), unit: .metric)
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var path: String {
        return type.endPoint
    }
    
    var method: HTTPMethod {
        return type.method
    }
    
    var parameters: [String: Any]? {
        return type.params
    }
    
    init(type: WeatherRequestType) {
        self.type = type
    }
    
}
