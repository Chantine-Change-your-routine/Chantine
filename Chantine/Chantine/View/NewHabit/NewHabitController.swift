//
//  NewHabitController.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 23/11/20.
//

import UIKit

class NewHabitController: UIViewController {

    private let titles = ["Data de início", "Lembrete", "Frequência"]
    private var exemples = ["Hoje", "08:00", "Todos os dias"]
    private let repeatText = ["Todos os dias", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupActionSheetCaller()
        addNavbarItems()
        view.backgroundColor = .white
        contentView.editionHabitTableView.register(EditionTableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.editionHabitTableView.delegate = self
        contentView.editionHabitTableView.dataSource = self
    }

    lazy var contentView: NewHabitView = {
        let view = NewHabitView()
        return view
    }()

    override func loadView() {
        view = contentView
    }

    func addNavbarItems() {
        title = "Novo Hábito"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self,
                                                           action: #selector(dismissModal))
        navigationItem.leftBarButtonItem?.tintColor = .actionColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self,
                                                            action: #selector(saveActivity))
        navigationItem.rightBarButtonItem?.tintColor = .actionColor
    }

    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func saveActivity() {
        self.dismiss(animated: true, completion: nil)
    }

    func setDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func didTapView() {
        view.endEditing(true)
    }

    private func setupActionSheetCaller() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.displayActionSheet))
        tap.numberOfTouchesRequired = 1
        contentView.petImageView.addGestureRecognizer(tap)
        contentView.petImageView.isUserInteractionEnabled = true
    }

    @objc private func displayActionSheet() {
        let optionalMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let choosePhoto = UIAlertAction(title: "Escolher Foto", style: .default, handler: importPicture)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        optionalMenu.addAction(choosePhoto)
        optionalMenu.addAction(cancel)

        self.present(optionalMenu, animated: true, completion: nil)
    }

}

extension NewHabitController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        contentView.petImageView.image = image
        dismiss(animated: true, completion: nil)
    }

    func importPicture(alert: UIAlertAction) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension NewHabitController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditionTableViewCell
        else {
            fatalError("Error")
    }

    cell.title.text = titles[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    cell.selectionStyle = .none
    cell.textField.placeholder = exemples[indexPath.row]
    if indexPath.row == 0 {
        cell.textField.inputView = generatePicker(pickerName: .startDate)
    }
    if indexPath.row == 1 {
        cell.textField.inputView = generatePicker(pickerName: .reminders)
    }
    if indexPath.row == 2 {
        cell.textField.inputView = generatePicker(pickerName: .frequencies)
    }
    return cell
  }
}

extension NewHabitController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        repeatText.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return repeatText[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: 2, section: 0))
            as? EditionTableViewCell
            else {
                fatalError("Error")
        }
        cell.textField.text = repeatText[row]
    }

}

enum Pickers {
    case startDate
    case reminders
    case frequencies
}

extension NewHabitController {

    private func generatePicker(pickerName: Pickers) -> UIView {
        let datePicker = UIDatePicker()
        let picker = UIPickerView()
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)

        switch pickerName {
        case .startDate:
            datePicker.datePickerMode = .date
            return datePicker
        case .reminders:
            datePicker.datePickerMode = .time
            return datePicker
        case .frequencies:
            picker.dataSource = self
            picker.delegate = self
            return picker
        }
    }

    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        if datePicker.datePickerMode == .date {
            guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: 0, section: 0))
                as? EditionTableViewCell
                else {
                    fatalError("Error")
            }
            cell.textField.text = datePicker.date.formattedDate
        } else {
            guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: 1, section: 0))
                as? EditionTableViewCell
                else {
                    fatalError("Error")
            }
            cell.textField.text = datePicker.date.formattedTime
        }

    }

}

extension Date {
    static let formatterDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        return formatter
    }()
    var formattedDate: String {
        return Date.formatterDate.string(from: self)
    }

    static let formatterTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    var formattedTime: String {
        return Date.formatterTime.string(from: self)
    }
}
