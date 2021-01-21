//
//  DetailsCell.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblValue1: UILabel!
    @IBOutlet weak var lblValue2: UILabel!

    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!
    @IBOutlet weak var lblValue3: UILabel!
    @IBOutlet weak var lblValue4: UILabel!

    var viewModel: DetailsViewModel? {
        didSet {
            self.setupUI()
        }
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        self.lblTitle1.font = BHFont.caption3.defaultValue
        self.lblTitle2.font = BHFont.caption3.defaultValue
        self.lblTitle3.font = BHFont.caption3.defaultValue
        self.lblTitle4.font = BHFont.caption3.defaultValue
        
        self.lblValue1.font = BHFont.body3.defaultValue
        self.lblValue2.font = BHFont.body3.defaultValue
        self.lblValue3.font = BHFont.body3.defaultValue
        self.lblValue4.font = BHFont.body3.defaultValue
        
        guard let viewModel = self.viewModel,
              let weatherModel = viewModel.weatherModel else { return }
        self.lblTitle1.text = BHText.details_sunrise.value
        self.lblTitle2.text = BHText.details_sunset.value
        self.lblTitle3.text = BHText.details_humidity.value
        self.lblTitle4.text = BHText.details_windspeed.value
        
        self.lblValue1.text = weatherModel.sunriseTime
        self.lblValue2.text = weatherModel.sunsetTime
        self.lblValue3.text = String(weatherModel.humidity ?? 0)
        self.lblValue4.text = String(weatherModel.windSpeed ?? 0.0)
    }
    
}
