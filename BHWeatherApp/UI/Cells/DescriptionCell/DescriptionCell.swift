//
//  DescriptionCell.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    
    var viewModel: DescriptionCellViewModel? {
        didSet {
            self.setupUI()
        }
    }
    
    private func setupUI() {
        
        self.lblDescription.font = BHFont.title1.defaultValue
        self.selectionStyle = .none
        
        guard let viewModel = self.viewModel,
              let weatherModel = viewModel.weatherModel else { return }
        self.lblDescription.text = (weatherModel.description ?? "").capitalized
    }
}
