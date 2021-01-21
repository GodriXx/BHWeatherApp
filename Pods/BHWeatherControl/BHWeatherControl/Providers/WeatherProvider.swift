//
//  WeatherProvider.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

/**
 
 Weather provider.
 
 - Author: Bassem Hatira
 
 - Note: WeatherProvider class give access to weather forecast methods
 
 */
public class WeatherProvider {
    
    //sharedProvider
    public static let shared = WeatherProvider()
    
    private var weatherWorker: WeatherWorker?
    
    private init() {
        self.weatherWorker = WeatherWorker()
    }
    
    /**
     getCurrentWeathers return simple array of weathers with minimum informations for multiple locations.
     
     
     - parameter locations: Multiple objects type of Location( lon: String, lat: String ).
     - parameter onSuccess: Callback contains array of WeatherWrapper.
     - parameter onError: Callback contains error in case of failure.
     
     # Notes: #
     1. Parameter locations must be an array of **BHWeatherCopntrol.Location** type
     
     # Example #
     ```
     let weatherProvider = WeatherProvider.shared
     
     weatherProvider.getCurrentWeathers(locations: locations) { (weathers) in
     print(weathers)
     } onError: { (error) in
     print(error)
     }
     ```
     */
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
    
    /**
     getWeatherDetails return detailed weather informations for a single location.
     
     
     - parameter location: Single object type of Location( lon: String, lat: String ).
     - parameter onSuccess: Callback contains WeatherWrapper? object.
     - parameter onError: Callback contains error in case of failure.
     
     # Notes: #
     1. Parameter location must be **BHWeatherCopntrol.Location** type
     
     # Example #
     ```
     let weatherProvider = WeatherProvider.shared
     
     weatherProvider.getWeatherDetails(location: location) { (weather) in
     print(weather)
     } onError: { (error) in
     print(error)
     }
     ```
     */
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
