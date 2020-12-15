//
//  RepetitionViewController.swift
//  Habbie
//
//  Created by José Mateus Azevedo on 08/12/20.
//

import UIKit

class RepetitionViewController: UIViewController {
    weak var delegateFrequencies: NewHabitDelegate?
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
        if let delegateFrequencies = delegateFrequencies {
            delegateFrequencies.setRepetition(repetition: repetitionChecks)
            if repetitionChecks.count > 0 {
                self.dismiss(animated: true)
            } else {
                let alert = UIAlertController(title: "Ops!", message: "Voce não selecionou nenhum dia.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
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
        
        if repetitionChecks.contains(indexPath.row + 1) == false {
            repetitionChecks.append(indexPath.row + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        repetitionChecks = repetitionChecks.filter { $0 != indexPath.row + 1 }
    }
    
}
