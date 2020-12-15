//
//  HabitRepositoryTests.swift
//  HabbieTests
//
//  Created by Brena Amorim on 08/12/20.
//

import XCTest
@testable import Habbie
import CoreData

class HabitRepositoryTests: XCTestCase {
    
    var habitRepository: HabitRepository!
    var coreDataStack: CoreDataStack!
    let nameOfHabit = "beber água"
    let dataHabit = HabitBiding(title: "beber água", goal: "ficar hidratada", startDate: Date(), reminders: Date(), imageID: 1, repetition: [1, 2, 3])
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        habitRepository = HabitRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        habitRepository = nil
    }
    
    func testCreateHabit_nameOfHabit() {
        //given
        let habitBiding = dataHabit
        
        //when
        let sut = habitRepository.create(data: habitBiding)
        
        //then
        XCTAssertEqual(sut?.title, nameOfHabit)
    }
    //obs: sut (system under test)
    
    func testRootContextIsSavedAfterAddingHabit() {
        //creates a background context and a new instance of HabitRepository which uses that context
        let derivedContext = coreDataStack.newDerivedContext()
        habitRepository = HabitRepository(managedObjectContext: derivedContext, coreDataStack: coreDataStack)
        
        //creates an expectation that sends a signal to the test case when the Core Data stack sends an NSManagedObjectContextDidSave notification event.
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) { _ in
            return true
        }
        
        //it adds a new habit inside a perform(_:) block. Executed asynchronously
        derivedContext.perform {
            let newHabit = self.habitRepository.create(data: self.dataHabit)

            XCTAssertNotNil(newHabit)
        }
        
        //The test waits for the signal that the habit saved. The test fails if it waits longer than two seconds.
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    //testing if the data saves to the persistent store
    
    func testReadAllHabits_returnsFirstHabit() {
        //given
        let newHabit = habitRepository.create(data: dataHabit)

        //when
        let readAllHabits = habitRepository.readAll()
        
        //then
        XCTAssertTrue(newHabit?.title == "beber água")

        XCTAssertNotNil(readAllHabits)
        XCTAssertEqual(readAllHabits.isEmpty, false)
    }

}
