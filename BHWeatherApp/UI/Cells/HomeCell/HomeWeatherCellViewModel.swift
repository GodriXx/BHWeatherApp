//
//  HomeWeatherCellViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

class HomeWeatherCellViewModel {
    
    var strTime: String?
    var strTemp: String?
    var strLocation: String?
    var imgWeather: UIImage?
    
    init(weatherModel: WeatherModel) {
        self.strTime = weatherModel.currentTime
        //TODO: update location Name
        self.strLocation = weatherModel.cityName
        self.strTemp = String(Int(weatherModel.temperature ?? 0.0))
        self.imgWeather = weatherModel.image
    }
    
}
