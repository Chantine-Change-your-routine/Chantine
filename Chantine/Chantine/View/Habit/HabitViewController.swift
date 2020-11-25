//
//  HabitViewController.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class HabitViewController: UIViewController {

    private let viewModel: HabitViewModel = HabitViewModel.shared

    override func loadView() {
        super.loadView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupLayout() {
        self.view.backgroundColor = .white

        let calendarWidth = UIScreen.main.bounds.width - 40
        let calendarView = CalendarView(width: calendarWidth, highlightedRanges: [])
        self.view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                          constant: 20).isActive = true
        calendarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
