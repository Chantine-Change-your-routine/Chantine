//
//  NewHabitViewModal.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 02/12/20.
//

import Foundation

class NewHabitViewModal: NewHabitViewModelProtocol {

    static let newHabitViewModal = NewHabitViewModal()
    let habitRepository = HabitRepository()

    func saveHabit(habit: HabitBiding) {
        self.habitRepository.create(data: habit)
    }

}
