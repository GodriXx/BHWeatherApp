//
//  AddLocationViewController.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit
import MapKit

protocol AddLocationProtocol: class {
    func update(with locations: [LocationCellViewModel])
    func handleError(error: Error)
}

class AddLocationViewController: UIViewController, StoryboardBased {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // Variales
    var homeViewDelegate: HomeViewDelegate?
    
    // Work items allow us to run tasks after delay with possibility to cancel it
    // this will allow us to cancel multiple request when typing search text and run only last one, same for error toast
    private var errorTask: DispatchWorkItem = DispatchWorkItem {}
    private var task: DispatchWorkItem = DispatchWorkItem {}
    
    private var viewModel: AddLocationViewModel = AddLocationViewModel()
    
    private var location: CLLocationCoordinate2D?
    
    // Constants
    private let delayToReload = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.view = self 
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBar.resignFirstResponder()
    }
    
    private func setupUI() {
        self.searchBar.barTintColor = .white
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.searchBar.setTextField(color: BHColor.lightGray.value)
        self.searchBar.delegate = self
        self.searchBar.placeholder = BHText.location_placeholder.value
        self.searchBar.becomeFirstResponder()
        
        // UITest identifier
        self.searchBar.accessibilityIdentifier = "xctest--searchBar"
        
        self.lblTitle.text = BHText.location_title.value
        
        self.setupTableView()
    }
    
    private func updateUI() {
        self.loader.stopAnimating()
        self.tableView.reloadData()
    }
    
    private func setupTableView() {
        // UITest identifier
        self.tableView.accessibilityIdentifier = "xctest--addTableView"
        self.tableView.registerCell(name: LocationCell.className)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
   
    private func performSearchLocation() {
        // cancel both tasks in case search text changed
        task.cancel()
        errorTask.cancel()
        
        // prepare errorTask instructions
        self.errorTask = DispatchWorkItem {
            ToastManager.displayToast(type: .Advice, with: 2.0, and: BHText.wrong_data.value)
        }
        
        //prepare main searh task instructions
        self.task = DispatchWorkItem {
            if let text = self.searchBar.text, !(self.searchBar.text?.isEmpty ?? true), ((self.searchBar.text?.count ?? 0) > 1) {
                self.loader.startAnimating()
                
                self.viewModel.getCities(text: text)


            } else if self.searchBar.text?.count == 1 {
                // run error task in case of error
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: self.errorTask)
            }
        }
        
        // run main search task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayToReload, execute: task)
    }

}

// SearchBar protocols
extension AddLocationViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if text.isEmpty {
            searchBar.showsCancelButton = false
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.performSearchLocation()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// TableView protocols
extension AddLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let locationCells = self.viewModel.locationCells else { return 0 }
        return locationCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let locationCells = self.viewModel.locationCells else {
            return UITableViewCell()
        }
        
        let cell: LocationCell = self.tableView.dequeueReusableCell(withIdentifier: LocationCell.className) as! LocationCell
    
        cell.viewModel = locationCells[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let locationCells = self.viewModel.locationCells else { return }
        let result = locationCells[indexPath.row]
        
        // ask for longitude/latitude for new location and save them in CoreData, then dismiss controller
        self.viewModel.getCoordinate(fromLocation: result) { (status) in
            if status {
                self.dismiss(animated: true) {
                    guard let homeViewDelegate = self.homeViewDelegate else { return }
                    // Update home using delegate
                    homeViewDelegate.updateData()
                }
            } else {
                // Display error if something went wrong in CoreData
                ToastManager.displayToast(type: .AddError, with: 2.0, and: BHText.already_exist.value)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//interface to update views in controller
extension AddLocationViewController: AddLocationProtocol {
    func handleError(error: Error) {
        self.loader.stopAnimating()
        ToastManager.displayToast(type: .APIError, with: 2.0, and: BHText.no_connection.value)
    }
    
    func update(with locations: [LocationCellViewModel]) {
        self.updateUI()
    }
}
