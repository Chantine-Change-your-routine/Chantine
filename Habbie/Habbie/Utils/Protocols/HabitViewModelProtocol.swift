//
//  HabitViewModelProtocol.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

protocol HabitViewModelProtocol {

//    static var habitRepository: HabitRepository { get }
//    static var calendarRepository: CalendarRepository { get }
    
    var habitData: HabitBindingData { get set }
    var calendarData: CalendarBindingData { get set }

    init(habitData: HabitBindingData)

    func getCardData() -> HabitBindingData
//    func getCalendarData() -> CalendarData
}
