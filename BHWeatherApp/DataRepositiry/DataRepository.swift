//
//  DataRepository.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 21/01/2021.
//

import Foundation
import BHWeatherControl

protocol DataRepositoryProtocol {
    func getCurrentWeathers(locations: [Location],
                            onCompleted: @escaping ([WeatherWrapper]?) -> Void)
    func getWeatherDetails(location: Location,
                           onCompleted: @escaping (WeatherWrapper?) -> Void)
    func getWeatherModels(onCompleted: @escaping ([WeatherModel]) -> Void)
    func removeWeather(weatherModel: WeatherModel,
                       onCompleted: @escaping(Bool) -> Void)
    func isWeatherExist(cityName: String) -> Bool
    func saveWeather(weatherModel: WeatherModel, onCompleted: @escaping(Bool) -> Void)
    func updateWeather(weatherModel: WeatherModel, onCompleted: @escaping(Bool) -> Void)
}

class DataRepository: DataRepositoryProtocol {
    
    //data base container
    private let dbManager = DataManager.shared
    
    //api client
    private let weatherProvider = WeatherProvider.shared
    
    func getCurrentWeathers(locations: [Location],
                            onCompleted: @escaping ([WeatherWrapper]?) -> Void) {
        self.weatherProvider.getCurrentWeathers(locations: locations) { (weathers) in
            onCompleted(weathers)
        } onError: { (error) in
            onCompleted(nil)
        }
    }
    
    func getWeatherDetails(location: Location,
                           onCompleted: @escaping (WeatherWrapper?) -> Void) {
        self.weatherProvider.getWeatherDetails(location: location) { (weather) in
            onCompleted(weather)
        } onError: { (error) in
            onCompleted(nil)
        }
        
    }
    
    func getWeatherModels(onCompleted: @escaping ([WeatherModel]) -> Void) {
        onCompleted(self.dbManager.getWeatherLocation())
    }
    
    func removeWeather(weatherModel: WeatherModel,
                       onCompleted: @escaping(Bool) -> Void) {
        
        self.dbManager.removeWeatherLocation(weatherModel: weatherModel) { (status) in
            onCompleted(status)
        }
        
    }
    
    func isWeatherExist(cityName: String) -> Bool {
        self.dbManager.isWeatherExist(cityName: cityName)
    }
    
    func saveWeather(weatherModel: WeatherModel, onCompleted: @escaping(Bool) -> Void) {
        self.dbManager.saveWeatherLocation(weatherModel: weatherModel) { (status) in
            onCompleted(status)
        }
    }
    
    func updateWeather(weatherModel: WeatherModel, onCompleted: @escaping(Bool) -> Void) {
        self.dbManager.updateWeather(weatherModel: weatherModel) { (status) in
            onCompleted(status)
        }
    }
    
}
