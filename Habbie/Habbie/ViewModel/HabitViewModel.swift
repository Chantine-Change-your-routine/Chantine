//
//  HabitViewModel.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

class HabitViewModel: HabitViewModelProtocol {
    let calendarRepository = CalendarRepository()

    var habitData: HabitBindingData
    var calendarData: CalendarBindingData

    required init(habitData: HabitBindingData) {
        self.habitData = habitData
         let rows = calendarRepository.readRows(habitID: habitData.identifier)
         let highlitedDays: [ClosedRange<Int>] = rows.map { Int($0.start)...Int($0.end) }
         self.calendarData = CalendarBindingData(month: 11, year: 2020, highlitedDaysRange: highlitedDays)
    }

    func getHabitTitle() -> String {
        return habitData.title
    }

    func getCardData() -> HabitBindingData {
        return self.habitData
    }

    func getHighlightDaysRange() -> [ClosedRange<Int>] {
        return self.calendarData.highlitedDaysRange
    }
}
