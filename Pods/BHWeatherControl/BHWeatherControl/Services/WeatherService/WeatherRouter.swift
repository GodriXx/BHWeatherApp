//
//  WeatherRouter.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

enum WeatherRequestType {
    case getCurrentWeather(location: Location, unit: Unit = .metric)
    case getWeatherDetails(location: Location, unit: Unit = .metric)
    
    var endPoint: String {
        switch self {
        case .getCurrentWeather(let location, let unit), .getWeatherDetails(let location, let unit):
            return "onecall?lat=\(location.lat)&lon=\(location.lon)&exclude=\(self.exclude )&units=\(unit.rawValue)&lang=\(Constants.appLang)&appid=\(BaseConfig.appID ?? "")"
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
