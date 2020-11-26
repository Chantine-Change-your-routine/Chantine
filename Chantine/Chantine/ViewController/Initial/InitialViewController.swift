//
//  InitialViewController.swift
//  Chantine
//
//  Created by Beatriz Carlos on 24/11/20.
//

import UIKit

class InitialViewController: UIViewController {
    let colorArray = [UIColor.blueLightColor, UIColor.greenLightColor, UIColor.yellowLightColor, UIColor.lavenderLightColor]
    let viewModel = InitialViewModel.initialViewModel
    
    var initialView: InitialView = {
        let view = InitialView()
        return view
    }()
    
    override func loadView() {
        view = initialView
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        navigationController?.navigationBar.barTintColor = .primaryColor
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .primaryColor
    }
    
    func configureTableView() {
        self.initialView.tableView.delegate = self
        self.initialView.tableView.dataSource = self
    }
}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = InitialView().tableView.dequeueReusableCell(withIdentifier: "InitialTableViewCell") as? InitialTableViewCell else {
            return InitialTableViewCell()
        }
        
        cell.setData(viewModel.getCellData(forIndex: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = HabitViewController()
        let habitViewModel = HabitViewModel(habitData: self.viewModel.getCellData(forIndex: indexPath.row))
        controller.viewModel = habitViewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
