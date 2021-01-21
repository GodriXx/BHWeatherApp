//
//  HomeWeatherCell.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

class HomeWeatherCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    
    var viewModel: HomeWeatherCellViewModel? {
        didSet {
            self.setupUI()
        }
    }
    
    func setupUI() {
        self.selectionStyle = .none
        // used for unitTest
        self.accessibilityIdentifier = "xctest--weatherCell"
        //setup fonts
        self.lblTemp.font = BHFont.caption1.defaultValue
        self.lblLocation.font = BHFont.title1.defaultValue
        self.lblTime.font = BHFont.body1.defaultValue
        //setup data
        guard let viewModel = self.viewModel else { return }
        self.lblTime.text = viewModel.strTime
        self.lblLocation.text = viewModel.strLocation
        self.lblTemp.text = viewModel.strTemp
        self.imgWeather.image = viewModel.imgWeather
    }
    
}
