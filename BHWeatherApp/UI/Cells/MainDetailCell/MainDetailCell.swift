//
//  MainDetailCell.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

class MainDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTemps: UILabel!
    @IBOutlet weak var lblRange: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    
    var viewModel: MainDetailCellViewModel? {
        didSet {
            self.setupUI()
        }
    }
    
    private func setupUI() {
        
        self.lblTemps.font = BHFont.title2.defaultValue
        self.lblName.font = BHFont.body4.defaultValue
        self.lblRange.font = BHFont.body1.defaultValue
        self.selectionStyle = .none
        
        guard let viewModel = self.viewModel,
              let weatherModel = viewModel.weatherModel else { return }
        
        self.lblName.text = weatherModel.cityName
        self.lblTemps.text = weatherModel.temperatureStr
        self.lblRange.text = weatherModel.currentTime
        self.imgWeather.image = weatherModel.image
    }
    
}
