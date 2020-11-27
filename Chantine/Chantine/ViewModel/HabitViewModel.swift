//
//  HabitViewModel.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

class HabitViewModel: HabitViewModelProtocol {
//    let calendarRepository = CalendarRepository()

    var habitData: HabitBindingData
    var calendarData: CalendarBindingData

    required init(habitData: HabitBindingData) {
        self.habitData = habitData
//         let rows = calendarRepository.readRows(habitID: habitData.identifier)
//         let highlitedDays: [ClosedRange<Int>] = rows.map { Int($0.start)...Int($0.end) }
//         self.calendarData = CalendarBindingData(month: 11, year: 2020, highlitedDaysRange: highlitedDays)

        self.calendarData = CalendarBindingData(month: 11, year: 2020,
                                                highlitedDaysRange: [1...5, 7...8, 12...20, 22...28])
    }

    func getCardData() -> HabitBindingData {
        return self.habitData
    }

    func getHighlightDaysRange() -> [ClosedRange<Int>] {
        return self.calendarData.highlitedDaysRange
    }

    func getHabitTitle() -> String {
        return self.habitData.title
    }
}
