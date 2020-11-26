//
//  InitialView.swift
//  Chantine
//
//  Created by Beatriz Carlos on 23/11/20.
//

import UIKit

class InitialView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ui components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, amigo."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .blackColor
        label.font = .roundedFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy var mascotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mascot")
        return imageView
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedFont(ofSize: 22, weight: .bold)
        label.text = "Atividades de hoje"
        label.textColor = .blackColor
        return label
    }()
    
    lazy var addHabitButon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button.tintColor = .actionColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    @objc func buttonTapped(_ : UIButton) {
        print("blabla")
    }
    
    lazy var viewTableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 30

        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.register(InitialTableViewCell.self, forCellReuseIdentifier: "InitialTableViewCell")
        return tableView
    }()
    
    func setupUI() {
        self.backgroundColor = .primaryColor
        settingConstraints()
    }
    
    func settingConstraints() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        self.addSubview(mascotImageView)
        NSLayoutConstraint.activate([
            mascotImageView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 18),
            mascotImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        self.addSubview(viewTableView)
        NSLayoutConstraint.activate([
            viewTableView.topAnchor.constraint(equalTo: self.mascotImageView.bottomAnchor, constant: 45),
            viewTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.viewTableView.addSubview(todayLabel)
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: self.viewTableView.topAnchor, constant: 43),
            todayLabel.leadingAnchor.constraint(equalTo: self.viewTableView.leadingAnchor, constant: 20)
        ])
        
        self.viewTableView.addSubview(addHabitButon)
        NSLayoutConstraint.activate([
            addHabitButon.topAnchor.constraint(equalTo: self.viewTableView.topAnchor, constant: 30),
            addHabitButon.trailingAnchor.constraint(equalTo: self.viewTableView.trailingAnchor, constant: -20),
            addHabitButon.heightAnchor.constraint(equalToConstant: 60),
            addHabitButon.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        self.viewTableView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.todayLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.viewTableView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.viewTableView.trailingAnchor)
        ])
    }
}
