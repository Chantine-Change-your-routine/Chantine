//
//  RepetitionView.swift
//  Habbie
//
//  Created by José Mateus Azevedo on 08/12/20.
//

import UIKit

class RepetitionView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 40
        
        return tableView
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.backgroundColor = .none
        button.setTitleColor(.actionColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar", for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.actionColor, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
           super.init(frame: frame)
           backgroundColor = .white
           setConstraints()
       }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints() {
        self.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
        self.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
