//
//  CalendarHistoryRepository.swift
//  Chantine
//
//  Created by Brena Amorim on 25/11/20.
//
//swiftlint:disable type_name
//swiftlint:disable function_body_length

import Foundation
import CoreData

class CalendarRepository: RepositoryProtocol {

    typealias T = CalendarHistory
    typealias A = CalendarBinding

    let coreDataStack = CoreDataStack.shared

    @discardableResult
    func create(data: CalendarBinding) -> CalendarHistory? {

        let calendar = CalendarHistory()
        calendar.identifier = data.identifier
        calendar.habitID = data.habitID
        calendar.month = Int16(data.month)
        calendar.year = Int16(data.year)

        do {
            try coreDataStack.mainContext.save()
            return  calendar
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
            return nil
        }

    }

    func read(identifier: String) -> CalendarHistory? {

        let calendar = Calendar.current
        let month = Int16(calendar.component(.month, from: Date()))
        let year = Int16(calendar.component(.year, from: Date()))

        let calendarFetchRequest: NSFetchRequest<CalendarHistory> = CalendarHistory.fetchRequest()
        calendarFetchRequest.predicate =
            NSPredicate(format: "habitID == %@ AND month == %i AND year == %i ", identifier, month, year)

        do {
            let result = try
                coreDataStack.mainContext.fetch(calendarFetchRequest)
            if result.count > 0 {
                if let calendarResult = result.first { return calendarResult } else {
                    return nil
                }
            }

        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
            return nil
        }

        return nil

    }

    func readAll() -> [CalendarHistory] {

        let calendarFetchRequest: NSFetchRequest<CalendarHistory> = CalendarHistory.fetchRequest()

        do {
            let results = try
                coreDataStack.mainContext.fetch(calendarFetchRequest)
            if results.count > 0 { //found a calendar
                return results
            } else { //
                return []
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
            return []
        }

    }

    func update(model: CalendarBinding) -> Bool {

        let calendarFetchRequest: NSFetchRequest<CalendarHistory> = CalendarHistory.fetchRequest()
        calendarFetchRequest.predicate = NSPredicate(format: "identifier == %@", model.identifier)

        do {
            let getCalendar = try coreDataStack.mainContext.fetch(calendarFetchRequest)
            if getCalendar.count > 0 {
                let objectUpdate = getCalendar[0] as NSManagedObject

                objectUpdate.setValue(model.month, forKey: "month")
                objectUpdate.setValue(model.year, forKey: "year")
            } else {
                return false
            }
            do {
                try coreDataStack.mainContext.save()
                return true
            } catch let error as NSError {
                print(error)
                return false
            }

        } catch let error as NSError {
            print(error)
            return false
        }

    }

    func delete(identifier: String) -> Bool {

        let calendarFetchRequest: NSFetchRequest<CalendarHistory> = CalendarHistory.fetchRequest()
        calendarFetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier)

        do {
            let getCalendar = try coreDataStack.mainContext.fetch(calendarFetchRequest)
            if getCalendar.count > 0 {
                // trying to fetch specific calendar
                let objectToDelete = getCalendar[0] as NSManagedObject
                coreDataStack.mainContext.delete(objectToDelete)
            } else {
                return false
            }
            do {
                try coreDataStack.mainContext.save()
                return true
            } catch let error as NSError {
                print(error)
                return false
            }

        } catch let error as NSError {
            print(error)
            return false
        }

    }

    func updateCurrentRow(habitID: String) -> Bool {

        let calendar = Calendar.current
        let dayStarted = Int16(calendar.component(.day, from: Date()))
        let month = Int16(calendar.component(.day, from: Date()))
        let year = Int16(calendar.component(.day, from: Date()))

        //fetch para calendar
        let calendarFetchRequest: NSFetchRequest<CalendarHistory> =
            CalendarHistory.fetchRequest()
        calendarFetchRequest.predicate =
            NSPredicate(format: "habitID == %@ AND month == %i AND year == %i", habitID, month, year)

        var calendarID: String

        do {
            let calendarResults = try coreDataStack.mainContext.fetch(calendarFetchRequest)
            if calendarResults.count > 0 {
                calendarID = calendarResults.first!.identifier!
            } else {
                return false
            }
        } catch {
            return false
        }

        //fetch para rows
        let rowsFetchRequest: NSFetchRequest<CalendarRows> =
            CalendarRows.fetchRequest()
        rowsFetchRequest.predicate = NSPredicate(format: "calendarID == %@", calendarID)

        do {
            let results = try
                coreDataStack.mainContext.fetch(rowsFetchRequest)
            // atualize calendarRows
            if results.count > 0 {
                let endIndex = results.map { $0.end }
                let today = Int16(calendar.component(.day, from: Date()))
                if endIndex.last! == today - 1 {
                    results.first!.end += 1
                }
            } else { //If don't exists calendarRows
                let calendarRow = CalendarRows()

                calendarRow.start = dayStarted
                calendarRow.end = dayStarted
                calendarRow.calendarID = calendarID
            }
            // save on coreDataStack
            do {
                try coreDataStack.mainContext.save()
                return true
            } catch let error as NSError {
                print(error)
                return false
            }

        } catch let error as NSError {
            print(error)
            return false
        }

    }

    func readRows(habitID: String) -> [CalendarRows] {
        if let calendar = self.read(identifier: habitID) {
            //fetch para rows
            let rowsFetchRequest: NSFetchRequest<CalendarRows> =
                CalendarRows.fetchRequest()
            rowsFetchRequest.predicate = NSPredicate(format: "calendarID == %@", calendar.identifier!)

            do {
                let results = try
                    coreDataStack.mainContext.fetch(rowsFetchRequest)
                return results
            } catch let error as NSError {
                print(error)
                return []
            }
        }
        return []
    }

}
