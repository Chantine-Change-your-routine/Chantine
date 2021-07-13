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
    
    let sections = ["Atividades de hoje", "Atividades concluídas"]
    
    var initialView: InitialView = {
        let view = InitialView()
        return view
    }()
    
    var refreshControl: UIRefreshControl?
    
    override func loadView() {
        view = initialView
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        navigationController?.navigationBar.barTintColor = .primaryColor
        setupUI()
        modalIndicatorGesture()
        addRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.realoadDataSource()
        self.initialView.tableView.reloadData()
    }

    func modalIndicatorGesture() {
        let modalIndicatorGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureIndicatorModal))
        modalIndicatorGesture.direction = .up
        modalIndicatorGesture.numberOfTouchesRequired = 1
        
        initialView.modalIndicator.addGestureRecognizer(modalIndicatorGesture)
        initialView.modalIndicator.isUserInteractionEnabled = true
    }
    
    @objc func gestureIndicatorModal(_ gesture: UISwipeGestureRecognizer) {
//        initialView.viewTableView.heightAnchor.constraint(equalToConstant: )
        let controller = InitialModalViewController()
        self.present(controller, animated: true)
        
        print("button pressed")
    }
    
    func setupUI() {
        view.backgroundColor = .primaryColor
        initialView.addHabitButon.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ : UIButton) {
        let controller = NewHabitController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureTableView() {
        self.initialView.tableView.delegate = self
        self.initialView.tableView.dataSource = self
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        guard let refreshControl = refreshControl else {return}
        refreshControl.tintColor = .actionColor
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        initialView.tableView.addSubview(refreshControl)
    }
    
    @objc func refreshTable() {
        self.viewModel.realoadDataSource()
        self.initialView.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.backgroundColor = .white

        if section == 0 {
            header.titleLabelHeader.text = sections[0]
        } else {
            header.titleLabelHeader.text = sections[1]
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.numberOfRows()
        }
        return viewModel.numberOfHabitsDone()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = InitialView().tableView.dequeueReusableCell(withIdentifier: "InitialTableViewCell") as? InitialTableViewCell else {
            return InitialTableViewCell()
        }
        let data = indexPath.section == 0 ? viewModel.getCellData(forIndex: indexPath.row) : viewModel.getHabitsDone(forIndex: indexPath.row)
        cell.setData(data)
        cell.identifier = data.identifier
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = HabitViewController()
        let habitViewModel = HabitViewModel(habitData: indexPath.section == 0 ? viewModel.getCellData(forIndex: indexPath.row) : viewModel.getHabitsDone(forIndex: indexPath.row))
        controller.viewModel = habitViewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
