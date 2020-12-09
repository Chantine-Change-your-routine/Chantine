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

    let newHabitViewModal = NewHabitViewModal.newHabitViewModal

//  instância do hábito que irá ser alterado
    var editedHabit: HabitBiding?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupActionSheetCaller()
        addNavbarItems()
        view.backgroundColor = .white
        contentView.editionHabitTableView.register(EditionTableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.editionHabitTableView.delegate = self
        contentView.editionHabitTableView.dataSource = self
        //testfunc()
    }
    func testfunc() {
        editedHabit = HabitBiding(title: "fdsafa", goal: "fsdfdsf", startDate: "21-12-2010", reminders: [Date()], imageID: 1, repetition: [1, 2], calendarHistoryID: "fdsfsdfsdf")
        fillHabitsFields()
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

    func fillHabitsFields() {
        contentView.titleTextField.text = editedHabit?.title
        contentView.objectiveTextField.text = editedHabit?.goal
        //changeDataOnCell(index: 0, text: editedHabit!.startDate)
    }

    @objc func dismissModal() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func saveActivity() {
        let habit = captureUserEntry()
        let newHabit = HabitBiding(title: habit.title, goal: habit.goal, startDate: habit.startDate, reminders: [Date()], imageID: 1, repetition: [1, 2], calendarHistoryID: habit.calendarHistoryID)
        newHabitViewModal.saveHabit(habit: newHabit)
        self.navigationController?.popViewController(animated: true)
    }

    private func captureUserEntry() -> HabitBiding {
        let title = contentView.titleTextField.text!
        let goal = contentView.objectiveTextField.text!
//      ver a lógica para salvar imagem
//        habit.imageID = contentView.petImageView.image
        let startDate = getDataOnCell(index: 0)
//      ver a lógica para salvar tais arrays
//        habit.reminders = Data(getDataOnCell(index: 1))
//        habit.repetition = getDataOnCell(index: 2)
        return HabitBiding(title: title, goal: goal, startDate: startDate, reminders: [Date()], imageID: 1, repetition: [1, 2], calendarHistoryID: "fsdfsdf")
    }

    private func getDataOnCell(index: Int) -> String {
        guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? EditionTableViewCell

        else {
            fatalError("Error")
        }
        return cell.textField.text!
    }

    private func changeDataOnCell(index: Int, text: String) {
        guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? EditionTableViewCell

        else {
            fatalError("Error")
        }

        cell.textField.text = text
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 2 {
        let controller = RepetitionViewController()
//        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationController?.present(controller, animated: true)
    }
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
//    if indexPath.row == 2 {
//        cell.textField.inputView = generatePicker(pickerName: .frequencies)
//    }
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

extension NewHabitController {

    private func generatePicker(pickerName: Pickers) -> UIView {
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
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
