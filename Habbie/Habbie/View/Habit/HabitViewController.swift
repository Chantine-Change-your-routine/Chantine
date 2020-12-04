//
//  HabitViewController.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class HabitViewController: UIViewController {

    var viewModel: HabitViewModel? {
        didSet {
            if let viewModel = self.viewModel {
                self.title = viewModel.getHabitTitle()
                self.updateLayout(habitData: viewModel.habitData)
            }
        }
    }

    private let calendarTitle: UILabel = {
        let label = UILabel()
        label.text = "Dias Concluídos"
        label.font = .roundedFont(ofSize: 20, weight: .medium)
        return label
    }()

    private let habitCardView: CardComponentView = {
        let cardView = CardComponentView(type: .descriptive)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 0.1
        return cardView
    }()

    private let calendarView = CalendarView()

    override func loadView() {
        super.loadView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .primaryColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editTapped))
        navigationItem.rightBarButtonItem?.tintColor = .actionColor
        navigationController?.navigationBar.tintColor = .actionColor
    }

    @objc private func editTapped() {
        let alert = UIAlertController(title: "Ops!", message: "Esta funcionalidade ainda não foi implementada.",
                                      preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }

    private func setupLayout() {
        self.view.backgroundColor = .white

        view.addSubview(habitCardView)
        habitCardView.translatesAutoresizingMaskIntoConstraints = false
        habitCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        habitCardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        habitCardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        habitCardView.heightAnchor.constraint(equalToConstant: 85).isActive = true

        view.addSubview(calendarTitle)
        calendarTitle.translatesAutoresizingMaskIntoConstraints = false
        calendarTitle.topAnchor.constraint(equalTo: habitCardView.bottomAnchor, constant: 30).isActive = true
        calendarTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        
        self.view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: calendarTitle.bottomAnchor,
                                          constant: 20).isActive = true
        calendarView.leftAnchor.constraint(equalTo: calendarTitle.leftAnchor).isActive = true
    }

    private func updateLayout(habitData: HabitBindingData) {
        if let viewModel = self.viewModel {
            calendarView.highlightedDaysRanges = viewModel.getHighlightDaysRange()
        }
        self.habitCardView.setData(habitData)
    }
}
