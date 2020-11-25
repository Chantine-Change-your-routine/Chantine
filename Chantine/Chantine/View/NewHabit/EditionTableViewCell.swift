//
//  EditionTableViewCell.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 25/11/20.
//

import UIKit

class EditionTableViewCell: UITableViewCell {

    var buttonTapCallback: () -> ()  = {
        print("dsdsds")
    }

    let buttonCell: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.contentHorizontalAlignment = .right

        return button
    }()

    let title: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
       return label
    }()

    @objc func didTapButton() {
        buttonTapCallback()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        title.widthAnchor.constraint(equalToConstant: 120).isActive = true

        contentView.addSubview(buttonCell)
        buttonCell.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        buttonCell.translatesAutoresizingMaskIntoConstraints = false
        buttonCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        buttonCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        buttonCell.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
