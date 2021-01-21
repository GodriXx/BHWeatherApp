//
//  HomeViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation
import BHWeatherControl

class HomeViewModel {
        
    private var dataRepo: DataRepositoryProtocol
    
    private var homeWeatherCellViewModels: [HomeWeatherCellViewModel]?
    var weatherModels: [WeatherModel] = []
    
    init(dataRepo: DataRepositoryProtocol = DataRepository()) {
        self.dataRepo = dataRepo
    }
    
    func getHomeWeatherModels(onCompleted: @escaping([WeatherModel]) -> Void) {
        
        self.dataRepo.getWeatherModels { (weatherModels) in
            
            self.weatherModels = weatherModels
            
            let locations = weatherModels.map { (weatherModel) -> Location in
                return Location(lat: weatherModel.latitude ?? "", lon: weatherModel.longitude ?? "")
            }
            
            self.dataRepo.getCurrentWeathers(locations: locations) { (weathers) in
                guard let weathers = weathers else {
                    //if no api response (offline) (return weatherModels from data base)
                    onCompleted(self.weatherModels)
                    return
                }
                
                for weather in weathers {
                    for weatherModel in self.weatherModels where weatherModel.compareLocation(lon: weather.longitude ?? "", lat: weather.latitude ?? "") {
                        weatherModel.updateDataFrom(weather: weather)
                        self.dataRepo.updateWeather(weatherModel: weatherModel) { (status) in
                            //data up to date
                        }
                    }
                }
                
                
                // after update data in weather models
                // (return weatherModels from api)
                onCompleted(self.weatherModels)
            }
            
            
        }
    }
    
    func getHomeWeatherCellViewModel(onCompleted: @escaping([HomeWeatherCellViewModel]) -> Void) {
            
            self.getHomeWeatherModels { (weatherModels) in
                
                self.homeWeatherCellViewModels = self.weatherModels.map({ (weatherModel) -> HomeWeatherCellViewModel in
                    return HomeWeatherCellViewModel(weatherModel: weatherModel)
                })
                
                onCompleted(self.homeWeatherCellViewModels ?? [])
                
            }
                    
    }
    
    func removeWeather(index: Int,
                       onCompletion: @escaping(Bool) -> Void) {
        
        self.dataRepo.removeWeather(weatherModel: self.weatherModels[index]) { (status) in
            if status {
                self.weatherModels.remove(at: index)
                onCompletion(true)
            } else {
                onCompletion(false)
            }
        }
        
    }
    
}
