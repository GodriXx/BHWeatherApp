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

//DataRepository provides an abstraction of data, so that can work with a simple abstraction that has an interface (DataRepositoryProtocol)
class DataRepository: DataRepositoryProtocol {
    
    //data base container
    private let dbManager = DataManager.shared
    
    //api client
    private let weatherProvider = WeatherProvider.shared
    
    // get current weather for multiple locations from BHWeatherControl API
    func getCurrentWeathers(locations: [Location],
                            onCompleted: @escaping ([WeatherWrapper]?) -> Void) {
        self.weatherProvider.getCurrentWeathers(locations: locations) { (weathers) in
            onCompleted(weathers)
        } onError: { (error) in
            onCompleted(nil)
        }
    }
    
    // get weather details for single location from BHWeatherControl API
    func getWeatherDetails(location: Location,
                           onCompleted: @escaping (WeatherWrapper?) -> Void) {
        self.weatherProvider.getWeatherDetails(location: location) { (weather) in
            onCompleted(weather)
        } onError: { (error) in
            onCompleted(nil)
        }
        
    }
    
    // get weather models from local storage
    func getWeatherModels(onCompleted: @escaping ([WeatherModel]) -> Void) {
        onCompleted(self.dbManager.getWeatherLocation())
    }
    
    // remove weather model from local storage
    func removeWeather(weatherModel: WeatherModel,
                       onCompleted: @escaping(Bool) -> Void) {
        
        self.dbManager.removeWeatherLocation(weatherModel: weatherModel) { (status) in
            onCompleted(status)
        }
        
    }
    
    // test if weather location exist in db by city name
    func isWeatherExist(cityName: String) -> Bool {
        self.dbManager.isWeatherExist(cityName: cityName)
    }
    
    // save new weather model into local storage
    func saveWeather(weatherModel: WeatherModel, onCompleted: @escaping(Bool) -> Void) {
        self.dbManager.saveWeatherLocation(weatherModel: weatherModel) { (status) in
            onCompleted(status)
        }
    }
    
    // update existing weather model into local storage
    func updateWeather(weatherModel: WeatherModel, onCompleted: @escaping(Bool) -> Void) {
        self.dbManager.updateWeather(weatherModel: weatherModel) { (status) in
            onCompleted(status)
        }
    }
    
}
