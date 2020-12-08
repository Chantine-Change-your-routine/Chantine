//
//  TestCoreDataStack.swift
//  HabbieTests
//
//  Created by Brena Amorim on 07/12/20.
//

import CoreData
import Habbie

class TestCoreDataStack: CoreDataStack {
    override init() {
    super.init()
    
    let coreDataStack = CoreDataStack()
    // 1
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType

    // 2
    let container = NSPersistentContainer(name: coreDataStack.modelName)
   
    // 3
    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    // 4
    storeContainer = container
    
  }
}
