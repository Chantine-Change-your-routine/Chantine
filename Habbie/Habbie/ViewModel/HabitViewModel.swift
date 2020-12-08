//
//  HabitViewModel.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

class HabitViewModel: HabitViewModelProtocol {
    var habitData: HabitBindingData

    required init(habitData: HabitBindingData) {
        self.habitData = habitData
    }

    func getCardData() -> HabitBindingData {
        return self.habitData
    }

    func getHighlightDaysRange() -> [ClosedRange<Int>] {
        let coreDataStack = CoreDataStack.shared
        let repository =  CalendarRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        let rows = repository.readRows(habitID: habitData.identifier)
        let highlitedDays: [ClosedRange<Int>] = rows.map { Int($0.start)...Int($0.end) }
        return highlitedDays
        //        self.calendarData = CalendarBindingData(month: 11, year: 2020,
        //                                                highlitedDaysRange: [1...5, 7...8, 12...20, 22...28])
    }

    func getHabitTitle() -> String {
        return self.habitData.title
    }
}
