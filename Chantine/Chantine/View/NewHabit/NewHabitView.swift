//
//  NewHabitView.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 23/11/20.
//

import UIKit

class NewHabitView: UIView {

    lazy var petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "drinking-water-thumbnail-with-text")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height/2
        self.addSubview(imageView)
        
        return imageView
    }()

    lazy var titleTextField: UITextField = {
        let title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        title.borderStyle = .roundedRect
        title.placeholder = "Beber água"
        title.textAlignment = .left
        title.clearButtonMode = .always
        self.addSubview(title)

        return title
    }()

    lazy var objectiveTextField: UITextField = {
        let title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        title.borderStyle = .roundedRect
        title.placeholder = "Ficar hidratado"
        title.textAlignment = .left
        title.clearButtonMode = .always
        self.addSubview(title)

        return title
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "Título"
        label.textAlignment = .left
        self.addSubview(label)

        return label
    }()

    lazy var objectiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "Objetivo"
        label.textAlignment = .left
        self.addSubview(label)

        return label
    }()

    lazy var editionHabitTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y,
                                 width: tableView.frame.size.width, height: tableView.contentSize.height)
        self.addSubview(tableView)

        return tableView
    }()

    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
//        picker.isHidden = false
//        //picker.translatesAutoresizingMaskIntoConstraints = false
//        picker.backgroundColor = UIColor.white
//        picker.setValue(UIColor.black, forKey: "textColor")
//        picker.autoresizingMask = .flexibleWidth
//        picker.contentMode = .center
//        picker.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: 100)
//        self.addSubview(picker)

        return picker
    }()

    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()

        return toolBar
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
        setPetImageViewConstraints()
        setTitleTextFieldConstraints()
        setTitleLabelConstraints()
        setObjectiveLabelConstraints()
        setObjectiveTextFieldConstraints()
        setEditionHabitTableViewConstraints()
    }

    func setPetImageViewConstraints() {
        NSLayoutConstraint.activate([
            petImageView.widthAnchor.constraint(equalToConstant: 70),
            petImageView.heightAnchor.constraint(equalToConstant: 70),
            petImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            petImageView.rightAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.rightAnchor),
            petImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: petImageView.rightAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    func setTitleTextFieldConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.leftAnchor.constraint(equalTo: petImageView.rightAnchor, constant: 20),
            titleTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setObjectiveLabelConstraints() {
        NSLayoutConstraint.activate([
            objectiveLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            objectiveLabel.topAnchor.constraint(equalTo: petImageView.bottomAnchor, constant: 26)
        ])
    }

    func setObjectiveTextFieldConstraints() {
        NSLayoutConstraint.activate([
            objectiveTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            objectiveTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),
            objectiveTextField.topAnchor.constraint(equalTo: objectiveLabel.bottomAnchor, constant: 5),
            objectiveTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setEditionHabitTableViewConstraints() {
        NSLayoutConstraint.activate([
            editionHabitTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            editionHabitTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),
            editionHabitTableView.topAnchor.constraint(equalTo: objectiveTextField.bottomAnchor, constant: 10),
            editionHabitTableView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
