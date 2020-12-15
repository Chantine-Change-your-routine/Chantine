//
//  PersistentContainer.swift
//  Chantine
//
//  Created by Brena Amorim on 25/11/20.
//
//swiftlint:disable type_name empty_count

import Foundation
import CoreData

class HabitRepository: RepositoryProtocol {
    typealias T = Habit
    typealias A = HabitBiding

    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }

    func create(data: HabitBiding) -> Habit? {
        guard let habit = NSEntityDescription.insertNewObject(forEntityName: "Habit", into: coreDataStack.mainContext) as? Habit else { return nil }
//        let habit = Habit(context: CoreDataStack.shared.mainContext)

        habit.identifier = data.identifier
        habit.title = data.title
        habit.goal = data.goal
        habit.startDate = data.startDate
        habit.reminders = data.reminders
        habit.imageID = data.imageID
        habit.repetition = data.repetition
        habit.currentProgress = Array(repeating: 0, count: data.repetition.count)

        let calendar = Calendar.current
        let month = Int16(calendar.component(.month, from: Date()))
        let year = Int16(calendar.component(.year, from: Date()))

        do {
            try coreDataStack.mainContext.save()
            let calendarRepository = CalendarRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
            calendarRepository.create(data: CalendarBinding(habitID: habit.identifier!, month: month, year: year, frequency: data.repetition))
            return habit
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
            return nil
        }

    }

    func read(identifier: String) -> Habit? {

        let habitFetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        habitFetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier)

        do {
            let result = try
                managedObjectContext.fetch(habitFetchRequest)
            if result.count > 0 {
                if let habit = result.first { return habit } else {
                    return nil
                }
            } else {
                return nil
            }

        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
            return nil
        }

    }

    func readAll() -> [Habit] {

        let habitFetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()

        do {
            let results = try managedObjectContext.fetch(habitFetchRequest)
            if results.count > 0 { //found a habit
                return results
            } else { //habit not found
                return []
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
            return []
        }

    }

    func update(model: HabitBiding) -> Bool {

        let habitFetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        habitFetchRequest.predicate = NSPredicate(format: "identifier == %@", model.identifier)

        do {
            let getHabit = try coreDataStack.mainContext.fetch(habitFetchRequest)
            if getHabit.count > 0 {
                let objectUpdate = getHabit[0] as NSManagedObject
                objectUpdate.setValue(model.title, forKey: "title")
                objectUpdate.setValue(model.goal, forKey: "goal")
                objectUpdate.setValue(model.startDate, forKey: "startDate")
                objectUpdate.setValue(model.reminders, forKey: "reminders")
                objectUpdate.setValue(model.imageID, forKey: "imageID")
                objectUpdate.setValue(model.repetition, forKey: "repetition")
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

        let habitFetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        habitFetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier)

        do {
            let getHabit = try coreDataStack.mainContext.fetch(habitFetchRequest)
            //trying to fetch habit
            if getHabit.count > 0 {
            let objectToDelete = getHabit[0] as NSManagedObject
            coreDataStack.mainContext.delete(objectToDelete)
            } else {
                return false
            }

            do {
                try coreDataStack.mainContext.save()
                return true
            } catch let error as NSError {
                print("Error: \(error), description: \(error.userInfo)")
                return false
            }

        } catch let error as NSError {
            print(error)
            return false
        }
    }

    func getTodayHabits() -> [Habit] {

        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        return readAll().filter { $0.repetition!.contains(weekday) }

    }
    
    func updateCurrentProgress(identifier: String) -> Bool {

        if let readHabit = read(identifier: identifier) {
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: Date())

            guard var progress = readHabit.currentProgress else { return false}
            guard let index = readHabit.repetition?.firstIndex(of: weekday) else { return false }

            if progress[index] == 1 {
                progress[index] = 0
            } else {
                progress[index] = 1
            }

            readHabit.currentProgress = progress

            do {
                try coreDataStack.mainContext.save()
                return true
            } catch let error as NSError {
                print("Error: \(error), description: \(error.userInfo)")
                return false
            }

        }

        return false

    }
    
}
