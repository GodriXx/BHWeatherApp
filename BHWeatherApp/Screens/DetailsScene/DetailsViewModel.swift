//
//  DetailsViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import Foundation
import BHWeatherControl

class DetailsViewModel {
    
    var weatherModel: WeatherModel?
    
    private var dataRepo: DataRepositoryProtocol = DataRepository()
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
    
    func getWeatherDetails(isCompleted: @escaping(Bool) -> Void) {
        
        guard let weatherModel = self.weatherModel else { return }
        
        let location = Location(lat: weatherModel.latitude ?? "", lon: weatherModel.longitude ?? "")
        self.dataRepo.getWeatherDetails(location: location) { (weatherWrapper) in
            
            guard let weatherWrapper = weatherWrapper else {
                //if no response api : data from db (offline)
                isCompleted(true)
                return
                
            }
            weatherModel.updateDataFrom(weather: weatherWrapper)
            self.dataRepo.updateWeather(weatherModel: weatherModel) { (status) in
                //data up to date
                // data from api
                isCompleted(true)
            }
        }
    }
}
