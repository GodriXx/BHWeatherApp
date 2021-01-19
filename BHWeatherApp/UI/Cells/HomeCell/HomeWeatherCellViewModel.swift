//
//  HomeWeatherCellViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit
import BHWeatherControl

class HomeWeatherCellViewModel {
    
    var strTime: String?
    var strTemp: String?
    var strLocation: String?
    var imgWeather: UIImage?
    
    init(weather: WeatherWrapper) {
        self.strTime = weather.currentTime
        //TODO: update location Name
        self.strLocation = weather.timezoneName
        self.strTemp = String(Int(weather.temperature ?? 0.0))
        self.imgWeather = UIImage(named: weather.icon ?? "")
    }
    
}
