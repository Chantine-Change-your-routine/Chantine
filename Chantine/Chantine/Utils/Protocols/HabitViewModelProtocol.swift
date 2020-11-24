//
//  HabitViewModelProtocol.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

protocol HabitViewModelProtocol {
//    func getCardData() -> HabitCardData {}

    // Calendar ViewModel Methods
    func getCalendarTitle() -> String
    func numberOfDays() -> Int
    func getDayDataModel(at index: Int) -> CalendarDayData
}
