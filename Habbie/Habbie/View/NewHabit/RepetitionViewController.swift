//
//  RepetitionViewController.swift
//  Habbie
//
//  Created by José Mateus Azevedo on 08/12/20.
//

import UIKit

class RepetitionViewController: UIViewController {

    private let repeatText = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]

    var repetitionChecks: [Int] = []

    lazy var contentView: RepetitionView = {
        let view = RepetitionView()
        view.cancelButton.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        view.saveButton.addTarget(self, action: #selector(clickSave), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repetir"
        contentView.tableView.register(RepetitionTableViewCell.self, forCellReuseIdentifier: "RepetitionTableViewCell")
        contentView.tableView.allowsMultipleSelection = true
        contentView.tableView.allowsMultipleSelectionDuringEditing = true
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }

    override func loadView() {
        view = contentView
    }

    @objc func clickCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @objc func clickSave(_ sender: UIButton) {
        
    }

}

extension RepetitionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repeatText.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepetitionTableViewCell", for: indexPath) as? RepetitionTableViewCell
        else {
            fatalError("Error")
        }
        cell.title.text = repeatText[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if repetitionChecks.contains(indexPath.row) == false {
//            if indexPath.row == 0 {
//                    repetitionChecks.append(contentsOf: [1, 2, 3, 4, 5, 6, 7])
//                //                contentView.tableView.allowsSelection = false
//            } else {
                repetitionChecks.append(indexPath.row + 1)
//            }

            print(repetitionChecks)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            repetitionChecks.removeAll()
//        } else {
            repetitionChecks = repetitionChecks.filter { $0 != indexPath.row + 1 }
//        }
        print(repetitionChecks)
    }

}
