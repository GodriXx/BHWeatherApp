//
//  WeatherProvider.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

public class WeatherProvider {
    
    public static let shared = WeatherProvider()
    private var weatherWorker: WeatherWorker?
    
    private init() {
        self.weatherWorker = WeatherWorker()
    }
    
    public func getCurrentWeathers(locations: [Location],
                                   onSuccess: @escaping ([WeatherWrapper]?) -> Void,
                                   onError: @escaping (Error?) -> Void) {
        guard let weatherWorker = self.weatherWorker else {
            onError(ConnexionError.internalError)
            return
        }
        weatherWorker.fetchCurrentWeathers(locations: locations) { (weathers, error) in
            guard let error = error else {
                onSuccess(weathers)
                return
            }
            onError(error)
        }
    }
    
    public func getWeatherDetails(location: Location,
                                  onSuccess: @escaping (WeatherWrapper?) -> Void,
                                  onError: @escaping (Error?) -> Void) {
        guard let weatherWorker = self.weatherWorker else {
            onError(ConnexionError.internalError)
            return
        }
        weatherWorker.fetchWeatherDetails(location: location) { (weather) in
            onSuccess(weather)
        } onError: { (error) in
            onError(error)
        }
    }
}
