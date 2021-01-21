//
//  DetailsCellViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import Foundation

class DetailsCellViewModel {
    
    var weatherModel: WeatherModel?
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
}
