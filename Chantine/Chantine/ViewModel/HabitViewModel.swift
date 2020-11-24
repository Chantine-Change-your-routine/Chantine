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

    private var days: [CalendarDayData] = []

    private init() {
        generateMockCalendar()
    }

    private func generateMockCalendar() {
        for number in 1...31 {
            let model = CalendarDayData(day: "\(number)")
            days.append(model)
        }
    }
}

extension HabitViewModel: HabitViewModelProtocol {
    func getCalendarTitle() -> String {
        return "Novembro, 2020"
    }

    func numberOfDays() -> Int {
        return days.count
    }

    func getDayDataModel(at index: Int) -> CalendarDayData {
        return days[index]
    }
}
