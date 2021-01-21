//
//  LocationCell.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    
    var viewModel: LocationCellViewModel? {
        didSet {
            self.setupUI()
        }
    }
    
    func setupUI() {
        self.selectionStyle = .none
        // used for unitTest
        self.accessibilityIdentifier = "xctest--locationCell"
        //setup fonts
        self.lblCity.font = BHFont.caption2.defaultValue
        self.lblRegion.font = BHFont.body2.defaultValue
        //setup data
        guard let viewModel = self.viewModel else { return }
        self.lblCity.text = viewModel.strCity
        self.lblRegion.text = viewModel.strRegion
    }
    
}
