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
        self.strLocation = weatherModel.cityName
        self.strTemp = weatherModel.temperatureStr
        self.imgWeather = weatherModel.image
    }
    
}
