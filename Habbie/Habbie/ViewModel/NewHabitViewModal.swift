//
//  NewHabitViewModal.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 02/12/20.
//

import Foundation

//swiftlint:disable unused_optional_binding
class NewHabitViewModel: NewHabitViewModelProtocol {
    private let habitRepository = HabitRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)

    @discardableResult
    func saveHabit(habit: HabitBiding) -> Bool {
        if let _ = self.habitRepository.create(data: habit) {
            return true
        }
        return false
    }
    
    @discardableResult
    func updateHabit(habit: HabitBiding) -> Bool {
        return self.habitRepository.update(model: habit)
    }
}
