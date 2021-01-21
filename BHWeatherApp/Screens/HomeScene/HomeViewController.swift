//
//  ViewController.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit
import BHWeatherControl

protocol HomeViewDelegate: class {
    func updateData()
}

class HomeViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    private var cellViewModels: [HomeWeatherCellViewModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.getWeatherData()
    }
    
    private func setupUI() {
        self.title = BHText.home_title.value
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddLocation))
        navigationItem.rightBarButtonItem = add
        add.accessibilityIdentifier = "xctest--btnAdd"
        
        self.lblEmpty.text = BHText.home_empty.value
    }
        
    private func getWeatherData() {
        self.loader.startAnimating()
        self.viewModel.getHomeWeatherCellViewModel { (homeWeatherCellViewModels) in
            self.loader.stopAnimating()
            self.tableView.isHidden = homeWeatherCellViewModels.isEmpty
            self.cellViewModels = homeWeatherCellViewModels
        }
    }
    
    private func setupTableView() {
        self.tableView.accessibilityIdentifier = "xctest--homeTableView"
        self.tableView.registerCell(name: HomeWeatherCell.className)
        self.tableView.separatorStyle = .none
    }
    
    @objc private func goToAddLocation() {
        let controller = AddLocationViewController.instanciate()
        controller.homeViewDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

//tableView protocols
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellViewModels = self.cellViewModels else {
            return 0
        }
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeWeatherCell = self.tableView.dequeueReusableCell(withIdentifier: HomeWeatherCell.className) as! HomeWeatherCell
        
        guard let cellViewModels = self.cellViewModels else {
            return UITableViewCell()
        }
        cell.viewModel = cellViewModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController.instanciate()
        
        detailsVC.viewModel = DetailsViewModel(weatherModel: self.viewModel.weatherModels[indexPath.row])
        self.show(detailsVC, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.viewModel.removeWeather(index: indexPath.row) { (status) in
                if status {
                    self.getWeatherData()
                }
            }
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    
    func updateData() {
        self.getWeatherData()
    }
}

