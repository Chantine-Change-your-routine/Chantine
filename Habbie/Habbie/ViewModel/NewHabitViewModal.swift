//
//  NewHabitViewModal.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 02/12/20.
//

import Foundation

class NewHabitViewModel: NewHabitViewModelProtocol {
    private let habitRepository = HabitRepository()

    @discardableResult
    func saveHabit(habit: HabitBiding) -> Bool {
        if let _ = self.habitRepository.create(data: habit) {
            return true
        }
        return false
    }
}
