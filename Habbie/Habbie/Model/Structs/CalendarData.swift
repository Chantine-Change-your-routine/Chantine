//
//  CalendarData.swift
//  Chantine
//
//  Created by Pedro Sousa on 25/11/20.
//

import Foundation

struct CalendarBindingData {
    let month: Int
    let year: Int
    let highlitedDaysRange: [ClosedRange<Int>]
}
