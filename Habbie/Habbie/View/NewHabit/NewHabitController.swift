//
//  NewHabitController.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 23/11/20.
//

import UIKit

class NewHabitController: UIViewController {
    let habitViewModel: NewHabitViewModel = NewHabitViewModel()
    
    private let titles = ["Data de início", "Lembrete", "Frequência"]
    private var exemples = ["2/9/20", "8:00 PM", "Seg, Ter, Qua ..."]
    private let repeatText = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"]
    private var repetitionTextField: UITextField?
    private var startDateTextField: UITextField?
    private var remainderTextField: UITextField?
    
    var repetitionChecks: [Int] = []
    
    //  instância do hábito que irá ser alterado
    var editedHabit: HabitBiding?
    
    lazy var contentView: NewHabitView = {
        let view = NewHabitView()
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = self.editedHabit {
            self.fillHabitsFields()
        }
    }
    
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
    
    override func loadView() {
        view = contentView
    }
    
    func fillHabitsFields() {
        if let editedHabit = editedHabit, let startDateTextField = startDateTextField, let remainderTextField = remainderTextField {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            
            contentView.titleTextField.text = editedHabit.title
            contentView.objectiveTextField.text = editedHabit.goal
            setRepetition(repetition: editedHabit.repetition)
            startDateTextField.text = dateFormatter.string(from: editedHabit.startDate)
            
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            remainderTextField.text = dateFormatter.string(from: editedHabit.reminders)
        }
    }
    
    func addNavbarItems() {
        title = "Novo Hábito"
        navigationController?.navigationBar.tintColor = .actionColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveActivity))
    }
    
    @objc func dismissModal() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveActivity() {
        if let habit = captureUserEntry() {
            if !self.habitViewModel.saveHabit(habit: habit) {
                let alert = UIAlertController(title: "Ops!", message: "Ocorreu um erro ao efetuar o cadastro.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ops!", message: "Ocorreu um erro ao efetuar o cadastro.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func captureUserEntry() -> HabitBiding? {
        let title = contentView.titleTextField.text!
        let goal = contentView.objectiveTextField.text!
        let random = Int.random(in: 1...4)
        
        guard let startDateTextField = startDateTextField else { return nil }
        guard let reminderTextField = remainderTextField else { return nil }
        
        let startDateText = "\(startDateTextField.text!), \(reminderTextField.text!)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        guard let startDate = dateFormatter.date(from: startDateText) else { return nil }
        if let identifier = editedHabit?.identifier {
            return HabitBiding(identifier: identifier, title: title, goal: goal, startDate: startDate, reminders: startDate, imageID: Int16(random), repetition: repetitionChecks.sorted())

        }
        
        return nil
    }
    
    func setDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // method action - tapGesture
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
//        present(ModalAvatarViewController(), animated: true)
        //        contentView.pickerAvatar.isHidden = false
        //        let optionalMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //
        //        let choosePhoto = UIAlertAction(title: "Escolher Foto", style: .default, handler: importPicture)
        //        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        //
        //        optionalMenu.addAction(choosePhoto)
        //        optionalMenu.addAction(cancel)
        //
        //        self.present(optionalMenu, animated: true, completion: nil)
    }
}

//extension NewHabitController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        guard let image = info[.editedImage] as? UIImage else { return }
//        contentView.petImageView.image = image
//        dismiss(animated: true, completion: nil)
//    }
//
//    func importPicture(alert: UIAlertAction) {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.delegate = self
//        present(picker, animated: true)
//    }
//}

extension NewHabitController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let controller = RepetitionViewController()
            controller.delegateFrequencies = self
            self.navigationController?.present(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditionTableViewCell else { fatalError("Error") }
        
        cell.title.text = titles[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textField.placeholder = exemples[indexPath.row]
        
        if indexPath.row == 0 {
            cell.textField.inputView = generatePicker(pickerName: .startDate)
            self.startDateTextField = cell.textField
        }
        
        if indexPath.row == 1 {
            cell.textField.inputView = generatePicker(pickerName: .reminders)
            self.remainderTextField = cell.textField
        }
        
        if indexPath.row == 2 {
            self.repetitionTextField = cell.textField
        }
        
        return cell
    }
}

extension NewHabitController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return repeatText.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return repeatText[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? EditionTableViewCell else { fatalError("Error") }
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
        
//        let picker = UIPickerView()
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        
        switch pickerName {
        case .startDate:
            datePicker.datePickerMode = .date
            return datePicker
        case .reminders:
            datePicker.datePickerMode = .time
            return datePicker
        }
    }
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        if datePicker.datePickerMode == .date {
            guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? EditionTableViewCell else {  return  }
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            cell.textField.text = dateFormatter.string(from: datePicker.date)
        } else {
            guard let cell = contentView.editionHabitTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EditionTableViewCell else {  return  }
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            cell.textField.text = dateFormatter.string(from: datePicker.date)
        }
        
    }
}

extension NewHabitController: NewHabitDelegate {
    func setRepetition(repetition: [Int]) {
        var weekDays: String = ""
        repetitionChecks = repetition
        var count = 0
        // criar o texto
        for day in repetitionChecks {
            if count == 2 {
                weekDays += ", \(repeatText[day - 1]) ..."
                break
            } else {
                weekDays += count == 0 ? repeatText[day - 1] : ", \(repeatText[day - 1])"
            }
            count += 1
        }
        
        if let textfield = repetitionTextField {
            textfield.text = weekDays
        }
    }
}
