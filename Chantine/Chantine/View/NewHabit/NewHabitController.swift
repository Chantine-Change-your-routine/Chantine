//
//  NewHabitController.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 23/11/20.
//

import UIKit

class NewHabitController: UIViewController {

    let titles = ["Data de início", "Lembretes", "Frequência"]
    let exemples = ["Hoje", "08:00, 10:00", "Todos os dias"]
    var toolBar = UIToolbar()
    var picker  = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        addNavbarItems()
        view.backgroundColor = .white
        contentView.editionHabitTableView.register(EditionTableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.editionHabitTableView.delegate = self
        contentView.editionHabitTableView.dataSource = self
        picker.dataSource = self
        picker.delegate = self
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
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self,
                                                            action: #selector(saveActivity))
        navigationItem.rightBarButtonItem?.tintColor = .orange
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

    func selectPicker(_ tag: Int) {
        showPicker()
        print(tag)
    }

    func showPicker() {
        picker = UIPickerView.init()
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300,
                                   width: UIScreen.main.bounds.size.width, height: 300)
        view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300,
                                                    width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self,
                                              action: #selector(onDoneButtonTapped))]
        view.addSubview(toolBar)
    }

    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
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
    cell.buttonCell.setTitle(exemples[indexPath.row], for: .normal)
    cell.buttonCell.tag = indexPath.row
    return cell
  }

}

extension NewHabitController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        titles.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titles[row]
    }

}
