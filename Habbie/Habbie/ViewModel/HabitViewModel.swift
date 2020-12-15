//
//  HabitViewModel.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

class HabitViewModel: HabitViewModelProtocol {
    private let calendarRepository = CalendarRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)
    private let habitRepository = HabitRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)
    
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
    
    func getHabit(indentifier: String) -> HabitBiding? {
        if let habit =  habitRepository.read(identifier: indentifier) {
            if let habitTitle = habit.title, let habitIdentifier = habit.identifier, let habitGoal = habit.goal, let habitStarDate = habit.startDate, let habitReminders = habit.reminders, let habitRepetition = habit.repetition {
                let habitBinding = HabitBiding(identifier: habitIdentifier, title: habitTitle, goal: habitGoal, startDate: habitStarDate, reminders: habitReminders, imageID: habit.imageID, repetition: habitRepetition)
                return habitBinding
            }
        }
        return nil
    }
    
    func getHabitIdentifier() -> String {
        return habitData.identifier
    }
}
