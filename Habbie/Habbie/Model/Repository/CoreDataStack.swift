//
//  CoreDataStack.swift
//  Chantine
//
//  Created by Brena Amorim on 25/11/20.
//

import Foundation
import CoreData

open class CoreDataStack {

    public let modelName: String = "Habbie"
    public static let shared = CoreDataStack()
    public init() {}

    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
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
}

extension CoreDataStack {

    func saveContext () {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

}
