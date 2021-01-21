//
//  WeatherWorker.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

/**
 
 WeatherWorker.
 
 - Author: Bassem Hatira
 
 - Note: WeatherWorker class implement the weather services
 
 */
class WeatherWorker: AbstractService<WeatherRouter> {
    
    /**
     fetchCurrentWeathers return array of WeatherWrapper & Error, for multiple locations.
     
     
     - parameter locations: Multiple objects type of Location( lon: String, lat: String ).
     - parameter onCompleted: Callback contains ([WeatherWrapper], Error).
     
     # Notes: #
     1. Parameter location must be an array of **BHWeatherCopntrol.Location** type
     
     */
    func fetchCurrentWeathers(locations: [Location], onCompleted: @escaping ([WeatherWrapper], Error?) -> Void) {
        
        // DispatchGroup automatically manages the thread creation for multiple asynch tasks
        let group = DispatchGroup()
        var weathers: [WeatherWrapper] = []
        var error: Error?
        
        locations.forEach { location in
            group.enter()
            
            // set routerType proprety of AbstractService to define a specific router
            routerType = WeatherRouter(type: .getCurrentWeather(location: location))
            
            self.execute { (weather: WeatherObject) in
                // get a simple weatherWrapper object
                weathers.append(weather.getWeatherWrapper())
                group.leave()
            } onError: { (theError) in
                error = theError
                group.leave()
            }
        }
        
        // notify the main thread when all task are completed
        group.notify(queue: .main) {
            //handle response
            onCompleted(weathers, error)
        }
    }
    
    /**
     fetchWeatherDetails return details of weathers for specific location.
     
     
     - parameter location: Location( lon: String, lat: String ).
     - parameter onSuccess: Callback contains WeatherWrapper Object.
     - parameter onError: Callback contains error in case of failure.
     
     # Notes: #
     1. Parameter location must be **BHWeatherCopntrol.Location** type
     
     */
    func fetchWeatherDetails(location: Location,
                             onSuccess: @escaping (WeatherWrapper?) -> Void,
                             onError: @escaping (Error?) -> Void) {
        
        // set routerType proprety of AbstractService to define a specific router
        routerType = WeatherRouter(type: .getWeatherDetails(location: location))
        
        self.execute { (weather: WeatherObject) in
            //handle success
            onSuccess(weather.getWeatherWrapper())
        } onError: { (error) in
            //handle error
            onError(error)
        }
    }
}
