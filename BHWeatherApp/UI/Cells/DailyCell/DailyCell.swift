//
//  DailyCell.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

class DailyCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblPrediction: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    
    var viewModel: DailyCellViewModel? {
        didSet {
            self.setupUI()
        }
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        //setup fonts
        self.lblDay.font = BHFont.body1.defaultValue
        self.lblPrediction.font = BHFont.body2.defaultValue
        self.lblMax.font = BHFont.body2.defaultValue
        self.lblMin.font = BHFont.body2.defaultValue
        
        //setup data
        guard let viewModel = self.viewModel,
              let dailyModel = viewModel.dailyModel else { return }
        self.lblDay.text = dailyModel.dayName
        self.imgWeather.image = dailyModel.image
        self.lblPrediction.text  = dailyModel.feelsLikeStr
        self.lblMax.text  = dailyModel.maxStr
        self.lblMin.text  = dailyModel.minStr
    }
}
