//
//  CoreDataStack.swift
//  Chantine
//
//  Created by Brena Amorim on 25/11/20.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    public let modelName: String = "Chantine"
    
    public static let shared = CoreDataStack()
    public init() {}
    
    lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    public func newDerivedContext() -> NSManagedObjectContext {
        let context = storeContainer.newBackgroundContext()
        return context
    }
    //background context for tests
}

extension CoreDataStack {
    
    func saveContext () {
        guard mainContext.hasChanges else { return }
        saveContext(mainContext)
    }
    
    public func saveContext(_ context: NSManagedObjectContext) {
        if context != mainContext {
            saveDerivedContext(context)
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    public func saveDerivedContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            self.saveContext(self.mainContext)
        }
    }
}
