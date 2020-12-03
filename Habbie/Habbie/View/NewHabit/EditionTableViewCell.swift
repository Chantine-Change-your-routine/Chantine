//
//  EditionTableViewCell.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 25/11/20.
//

import UIKit

class EditionTableViewCell: UITableViewCell {

    let buttonCell: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.contentHorizontalAlignment = .right

        return button
    }()

    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = false
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: 100)
        self.addSubview(picker)
        return picker
    }()

    let title: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
       return label
    }()

    @objc func didTapButton(sender: UIButton) {
        NewHabitController().selectPicker(sender.tag)
    }

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

        contentView.addSubview(buttonCell)
        buttonCell.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        buttonCell.translatesAutoresizingMaskIntoConstraints = false
        buttonCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        buttonCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        buttonCell.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

}
