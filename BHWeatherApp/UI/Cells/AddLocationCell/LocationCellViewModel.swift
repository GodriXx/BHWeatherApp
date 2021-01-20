//
//  LocationCellViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import Foundation
import MapKit

class LocationCellViewModel {
    
    var mkLocation: MKLocalSearchCompletion
    var strCity: String?
    var strRegion: String?
    
    init(mkLocation: MKLocalSearchCompletion) {
        self.mkLocation = mkLocation
        self.strCity = mkLocation.title
        self.strRegion = mkLocation.subtitle
    }
    
}
