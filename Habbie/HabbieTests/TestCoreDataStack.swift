//
//  TestCoreDataStack.swift
//  HabbieTests
//
//  Created by Brena Amorim on 07/12/20.

import CoreData
import Habbie

class TestCoreDataStack: CoreDataStack {
    override init() {
    super.init()

    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType
    
    let container = NSPersistentContainer(
        name: CoreDataStack.modelName,
        managedObjectModel: CoreDataStack.model)

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
