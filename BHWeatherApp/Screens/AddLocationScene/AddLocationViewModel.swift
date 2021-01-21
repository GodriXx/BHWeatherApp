//
//  AddLocationViewModel.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import Foundation
import MapKit

class AddLocationViewModel: NSObject {
    
    weak var view: AddLocationProtocol?
    
    private var dataRepo: DataRepositoryProtocol = DataRepository()
    
    var locationCells: [LocationCellViewModel]? {
        didSet {
            guard let locationCells = locationCells,
                  let view = self.view else { return }
            view.update(with: locationCells)
        }
    }
    
    // Create a seach completer object
    var searchCompleter = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        self.searchCompleter.delegate = self
    }
    
    func getCities(text: String) {
        self.searchCompleter.queryFragment = text
    }
    
    func getCoordinate(fromLocation location: LocationCellViewModel, onCompletion: @escaping(Bool) -> Void ) {
        
        let searchRequest = MKLocalSearch.Request(completion: location.mkLocation)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            if error == nil {
                guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                    onCompletion(false)
                    return
                }
                
                if !self.dataRepo.isWeatherExist(cityName: location.strCity ?? "") {
                    let weatherModel = WeatherModel(cityName: location.strCity,
                                                    citySubtitle: location.strRegion,
                                                    coordinate: coordinate)
                    
                    self.dataRepo.saveWeather(weatherModel: weatherModel) { (status) in
                        onCompletion(status)
                    }
                    
                } else {
                    onCompletion(false)
                }
            } else {
                onCompletion(false)
            }
        }
    }
    
}

extension AddLocationViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        // Setting our searcResults variable to the results that the searchCompleter returned
        self.locationCells = completer.results.map { (mkLocation) -> LocationCellViewModel in
            return LocationCellViewModel(mkLocation: mkLocation)
        }
        
    }
}
