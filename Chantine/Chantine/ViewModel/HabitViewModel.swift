//
//  HabitViewModel.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

class HabitViewModel {
    public static let shared = HabitViewModel()
//    private let habitRepository = HabitRepository()
//    private let calendarRepository = CalendarHistoryRepository()

//    private var days: [(Int, Int)] = []

    private init() {}
}

extension HabitViewModel: HabitViewModelProtocol {
    func getHighlightDaysRange(month: Int, year: Int) -> [ClosedRange<Int>] {
        return [1...5, 7...8, 12...20, 22...28]
    }
}
