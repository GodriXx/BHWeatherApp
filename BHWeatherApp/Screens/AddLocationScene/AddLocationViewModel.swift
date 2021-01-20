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
    var locationCells: [LocationCellViewModel]? {
        didSet {
            guard let locationCells = locationCells else { return }
            view?.update(with: locationCells)
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
    
    func getCoordinate(fromLocation location:LocationCellViewModel) -> CLLocationCoordinate2D {
        
        let searchRequest = MKLocalSearch.Request(completion: location.mkLocation)
        var locationCoordinate: CLLocationCoordinate2D?
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            
            locationCoordinate = coordinate
            
            print(coordinate)
            
        }
        return locationCoordinate ?? CLLocationCoordinate2D()
    }
}

extension AddLocationViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        // Setting our searcResults variable to the results that the searchCompleter returned
        self.locationCells = completer.results.map { (mkLocation) -> LocationCellViewModel in
            return LocationCellViewModel(mkLocation: mkLocation)
        }
        
        // Reload the tableview with our new searchResults
        print(completer.results)
    }
}
