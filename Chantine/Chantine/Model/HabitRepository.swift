//
//  PersistentContainer.swift
//  Chantine
//
//  Created by Brena Amorim on 25/11/20.
//

import Foundation
import CoreData

var container: NSPersistentContainer!


container = NSPersistentContainer(name: "Chantine")
container.loadPersistentStores { storeDescription, error in
    if let error = error {
        print("Unresolved error \(error)")
    }
}
