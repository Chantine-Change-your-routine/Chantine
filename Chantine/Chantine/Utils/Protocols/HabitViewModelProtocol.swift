//
//  HabitViewModelProtocol.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

protocol HabitViewModelProtocol {
//    func getCardData() -> HabitCardData
    func getHighlightDaysRange(month: Int, year: Int) -> [ClosedRange<Int>]
}
