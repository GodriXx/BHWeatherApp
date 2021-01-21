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
}

class AddLocationViewController: UIViewController, StoryboardBased {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var homeViewDelegate: HomeViewDelegate?
    
    private let delayToReload = 0.3
    
    private var errorTask: DispatchWorkItem = DispatchWorkItem {}
    private var task: DispatchWorkItem = DispatchWorkItem {}
    
    private var viewModel: AddLocationViewModel = AddLocationViewModel()
    
    private var location: CLLocationCoordinate2D?
    
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
        
        self.searchBar.accessibilityIdentifier = "xctest--searchBar"
        
        self.lblTitle.text = BHText.location_title.value
        
        self.setupTableView()
    }
    
    private func updateUI() {
        self.loader.stopAnimating()
        self.tableView.reloadData()
    }
    
    private func setupTableView() {
        self.tableView.accessibilityIdentifier = "xctest--addTableView"
        self.tableView.registerCell(name: LocationCell.className)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
   
    private func performSearchLocation() {
        task.cancel()
        errorTask.cancel()
        
        self.errorTask = DispatchWorkItem {
            ToastManager.displayToast(type: .Advice, with: 2.0, and: BHText.wrong_data.value)
        }
        
        self.task = DispatchWorkItem {
            if let text = self.searchBar.text, !(self.searchBar.text?.isEmpty ?? true), ((self.searchBar.text?.count ?? 0) > 1) {
                self.loader.startAnimating()
                
                self.viewModel.getCities(text: text)


            } else if self.searchBar.text?.count == 1 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: self.errorTask)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayToReload, execute: task)
    }

}

extension AddLocationViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
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
        
        self.viewModel.getCoordinate(fromLocation: result) { (status) in
            if status {
                self.dismiss(animated: true) {
                    guard let homeViewDelegate = self.homeViewDelegate else { return }
                    homeViewDelegate.updateData()
                }
            } else {
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
    func update(with locations: [LocationCellViewModel]) {
        self.updateUI()
    }
}
