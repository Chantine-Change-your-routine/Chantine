//
//  NewHabitController.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 23/11/20.
//

import UIKit

class NewHabitController: UIViewController {

    var titles = ["Data de início", "Lembretes", "Frequência"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
    cell.buttonCell.setTitle(titles[indexPath.row], for: .normal)
    return cell
  }

}
