//
//  HabitViewController.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class HabitViewController: UIViewController {

    private let viewModel: HabitViewModel = HabitViewModel.shared

    private let calendarView = CalendarView(size: CGSize(width: UIScreen.main.bounds.width - 40,
                                                         height: UIScreen.main.bounds.width - 15))

    override func loadView() {
        super.loadView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calendarView.delegate = self
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(calendarView)
        calendarView.title = viewModel.getCalendarTitle()
        calendarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                          constant: 20).isActive = true
        calendarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}

extension HabitViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfDays()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = viewModel.getDayDataModel(at: indexPath.row)
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CalendarViewDayCell.identifier,
                for: indexPath) as? CalendarViewDayCell else {
            return CalendarViewDayCell()
        }
        cell.configure(with: day)
        return cell
    }
}
