//
//  WeatherWorker.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

class WeatherWorker: AbstractService<WeatherRouter> {
    
    func fetchCurrentWeathers(locations: [Location], onCompleted: @escaping ([WeatherObject], Error?) -> Void) {
        
        let group = DispatchGroup()
        var weathers: [WeatherObject] = []
        var error: Error?
        
        locations.forEach { location in
            group.enter()
            
            routerType = WeatherRouter(type: .getCurrentWeather(location: location))
            
            self.execute { (weather: WeatherObject) in
                weathers.append(weather)
                group.leave()
            } onError: { (theError) in
                error = theError
                group.leave()
            }
        }
        
        // notify the main thread when all task are completed
        group.notify(queue: .main) {
            onCompleted(weathers, error)
        }
    }
    
    func fetchWeatherDetails(location: Location,
                             onSuccess: @escaping (WeatherObject?) -> Void,
                             onError: @escaping (Error?) -> Void) {
        
        routerType = WeatherRouter(type: .getWeatherDetails(location: location))
        
        self.execute { (weather: WeatherObject) in
            onSuccess(weather)
        } onError: { (error) in
            onError(error)
        }
    }
}
