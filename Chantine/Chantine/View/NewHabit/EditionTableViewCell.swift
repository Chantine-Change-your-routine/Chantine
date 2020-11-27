//
//  EditionTableViewCell.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 25/11/20.
//

import UIKit

class EditionTableViewCell: UITableViewCell {

    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 17)

        return textField
    }()

    let title: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
       return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        title.widthAnchor.constraint(equalToConstant: 120).isActive = true

        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }

}
