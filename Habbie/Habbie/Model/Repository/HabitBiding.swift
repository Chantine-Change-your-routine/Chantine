//
//  HabitBiding.swift
//  Chantine
//
//  Created by Brena Amorim on 25/11/20.
//

import Foundation

struct HabitBiding {
    let identifier: String = UUID().uuidString
    let title: String
    let goal: String
    let startDate: Date
    let reminders: Date
    let imageID: Int16
    let repetition: [Int]
    let calendarHistoryID: String
}
