//
//  DetailsViewController.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

class DetailsViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupTableView()
        self.getDetails()
    }
    
    private func setupUI() {
        self.title = BHText.details_title.value
    }
    
    private func setupTableView() {
        self.tableView.registerCell(name: MainDetailCell.className)
        self.tableView.registerCell(name: DailyCell.className)
        self.tableView.registerCell(name: DescriptionCell.className)
        self.tableView.registerCell(name: DetailsCell.className)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }
    
    private func getDetails() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.getWeatherDetails { (status) in
            if status {
                self.updateUI()
            }
        }
        
    }
    
    func updateUI() {
        tableView.reloadData()
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return 1
        } else  if section == 1 {
            guard let viewModel = self.viewModel,
                  let weatherModel = viewModel.weatherModel,
                  let days = weatherModel.days else { return 0 }
            return days.count
        } else if section == 3 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = self.viewModel, let weatherModel = viewModel.weatherModel else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            let cell: MainDetailCell = tableView.dequeueReusableCell(withIdentifier: MainDetailCell.className) as! MainDetailCell
            cell.viewModel = MainDetailCellViewModel(weatherModel: weatherModel)
            return cell
        } else  if indexPath.section == 1 {
            let cell: DailyCell = tableView.dequeueReusableCell(withIdentifier: DailyCell.className) as! DailyCell
            guard let days = weatherModel.days else { return UITableViewCell() }
            cell.viewModel = DailyCellViewModel(dailyModel: days[indexPath.row])
            return cell
        } else  if indexPath.section == 2 {
            let cell: DescriptionCell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.className) as! DescriptionCell
            cell.viewModel = DescriptionCellViewModel(weatherModel: weatherModel)
            return cell
        } else if indexPath.section == 3 {
            let cell: DetailsCell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.className) as! DetailsCell
            cell.viewModel = DetailsViewModel(weatherModel: weatherModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
