//
//  Calendar.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//
import Foundation

extension Calendar {

    public var currentYear: Int {
        return self.component(.year, from: Date())
    }

    private static let monthsNames = ["Janeiro", "Fevereiro", "Março",
                                      "Abril", "Maio", "Junho",
                                      "Julho", "Agosto", "Setembro",
                                      "Outubro", "Novembro", "Dezembro"]

    func monthName(date: Date = Date()) -> String {
        let month = self.component(.month, from: date)
        return Calendar.monthsNames[month - 1]
    }

    func firstWeekdayOfMonth(date: Date = Date()) -> Int {
        guard let date = self.date(from: self.dateComponents([.year, .month], from: date)) else { return 0 }
        return self.component(.weekday, from: date)
    }

    func lastWeekdayOfMonth(date: Date = Date()) -> Int {
        let lastDay = self.numberOfDays()
        let components = DateComponents(year: self.component(.year, from: date),
                                        month: self.component(.month, from: date),
                                        day: lastDay)
        guard let lastDayDate = self.date(from: components) else { return 0 }
        return self.component(.weekday, from: lastDayDate)
    }

    func numberOfDays(date: Date = Date()) -> Int {
        guard let numberOfDaysInMonth = self.range(of: .day, in: .month, for: date) else { return 0 }
        return numberOfDaysInMonth.count
    }

    func lastDayOfPastMonth(date: Date = Date()) -> Int {
        let dateComponents = DateComponents(year: self.component(.year, from: date),
                                            month: self.component(.month, from: date))
        let firstDayDate = self.date(from: dateComponents)!
        let lastDayDate = self.date(byAdding: .day, value: -1, to: firstDayDate)!
        return self.component(.day, from: lastDayDate)
    }
}
