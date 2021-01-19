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
    
    func getHomeWeathers(locations: [Location],
                         onSuccess: @escaping([HomeWeatherCellViewModel]) -> Void,
                         onError: @escaping(Error) -> Void) {
        weatherProvider.getCurrentWeathers(locations: locations) { (weathers) in
            
            self.homeWeatherCell = weathers?.map({ (weather) -> HomeWeatherCellViewModel in
                return HomeWeatherCellViewModel(weather: weather)
            })
            
            onSuccess(self.homeWeatherCell ?? [])
        } onError: { (error) in
            print(error ?? "")
        }
    }
}
