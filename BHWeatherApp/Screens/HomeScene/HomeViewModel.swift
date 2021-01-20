//
//  HomeViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation
import BHWeatherControl

class HomeViewModel {
    
    private var weatherProvider = WeatherProvider.shared
    
    var homeWeatherCell: [HomeWeatherCellViewModel]?
    var weatherModels: [WeatherModel] = []
    
    func getHomeWeathers(onSuccess: @escaping([HomeWeatherCellViewModel]) -> Void,
                         onError: @escaping(Error) -> Void) {
        
        self.weatherModels = DataManager.shared.getWeatherLocation()
        
        let locations = weatherModels.map { (weatherModel) -> Location in
            return Location(lat: weatherModel.latitude ?? "", lon: weatherModel.longitude ?? "")
        }
        
        weatherProvider.getCurrentWeathers(locations: locations) { (weathers) in
            guard let weathers = weathers else {
                onError(NSError())
                return
            }
            
            for weather in weathers {
                for weatherModel in self.weatherModels where weatherModel.compareLocation(lon: weather.longitude ?? "", lat: weather.latitude ?? "") {
                    weatherModel.updateDataFrom(weather: weather)
                }
            }
            
            self.homeWeatherCell = self.weatherModels.map({ (weatherModel) -> HomeWeatherCellViewModel in
                return HomeWeatherCellViewModel(weatherModel: weatherModel)
            })
            onSuccess(self.homeWeatherCell ?? [])
        } onError: { (error) in
            print(error ?? "")
        }
    }
    
    func removeWeather(index: Int,
                       onCompletion: @escaping(Bool) -> Void) {
        //DataManager.deleteData(weather: weatherModels[indexPath.row])
        DataManager.shared.removeWeatherLocation(weatherModel: self.weatherModels[index]) { (status) in
            if status {
                self.weatherModels.remove(at: index)
                onCompletion(true)
            } else {
                onCompletion(false)
            }
        }
        
    }
    
}
