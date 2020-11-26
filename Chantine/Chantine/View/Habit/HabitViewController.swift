//
//  HabitViewController.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class HabitViewController: UIViewController {

    var viewModel: HabitViewModel?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Título do Hábito"
        label.font = .roundedFont(ofSize: 22, weight: .medium)
        return label
    }()

    private let habitCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.2
        return view
    }()

    override func loadView() {
        super.loadView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    private func setupNavBar() {
        self.title = "Hábito"
        navigationController?.navigationBar.backgroundColor = .systemGray5
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
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

        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true

        view.addSubview(habitCardView)
        habitCardView.translatesAutoresizingMaskIntoConstraints = false
        habitCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        habitCardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        habitCardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        habitCardView.heightAnchor.constraint(equalToConstant: 85).isActive = true

        var highlitedDaysRange = [ClosedRange<Int>]()
        if let viewModel = self.viewModel {
            titleLabel.text = viewModel.getHabitTitle()
            highlitedDaysRange = viewModel.getHighlightDaysRange()
        }

        let calendarWidth = UIScreen.main.bounds.width - 40
        let calendarView = CalendarView(width: calendarWidth,
                                        highlightedDaysRanges: highlitedDaysRange)
        self.view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: habitCardView.bottomAnchor,
                                          constant: 20).isActive = true
        calendarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
