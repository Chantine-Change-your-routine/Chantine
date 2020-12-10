//
//  CalendarRepository.swift
//  Chantine
//
//  Created by Brena Amorim on 25/11/20.
//

import Foundation
import CoreData

//swiftlint:disable type_name
class CalendarRepository: RepositoryProtocol {
    
    typealias T = CalendarHistory
    typealias A = CalendarBinding
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    @discardableResult
    func create(data: CalendarBinding) -> CalendarHistory? {
        guard let calendar = NSEntityDescription.insertNewObject(forEntityName: "CalendarHistory", into: coreDataStack.mainContext) as? CalendarHistory else { return nil }
        //        let calendar = CalendarHistory(context: coreDataStack.mainContext)
        calendar.identifier = data.identifier
        calendar.habitID = data.habitID
        calendar.month = Int16(data.month)
        calendar.year = Int16(data.year)
        calendar.lastDayDone = 0
        calendar.frequency = data.frequency
        
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
        guard let currentCalendar = self.read(identifier: habitID) else { return false }
        
        let rowsFetchRequest: NSFetchRequest<CalendarRows> = CalendarRows.fetchRequest()
        rowsFetchRequest.predicate = NSPredicate(format: "calendarID == %@", currentCalendar.identifier!)
        
        do {
            let results = try coreDataStack.mainContext.fetch(rowsFetchRequest)
            
            let today = Date()
            let todayDay = Int16(calendar.component(.day, from: today))
            
            if let lastResult = results.last {
                if  let lastDayDoneIndex = currentCalendar.frequency!.firstIndex(of: Int(currentCalendar.lastDayDone)),
                    let todayIndex = currentCalendar.frequency!.firstIndex(of: Int(todayDay)) {
                    
                    if todayIndex - lastDayDoneIndex == 1 {
                        if lastResult.end == todayDay {
                            lastResult.end = currentCalendar.lastDayDone
                        } else {
                            currentCalendar.lastDayDone = lastResult.end
                            lastResult.end = todayDay
                        }
                    } else {
                        let calendarRow = CalendarRows(context: coreDataStack.mainContext)
                        calendarRow.start = todayDay
                        calendarRow.end = todayDay
                        calendarRow.calendarID = currentCalendar.identifier
                        currentCalendar.lastDayDone = todayDay
                    }
                    
                } else {
                    return false
                }
                
            } else {
                let calendarRow = CalendarRows(context: coreDataStack.mainContext)
                calendarRow.start = todayDay
                calendarRow.end = todayDay
                calendarRow.calendarID = currentCalendar.identifier
                currentCalendar.lastDayDone = todayDay
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
