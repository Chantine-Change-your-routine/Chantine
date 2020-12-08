//
//  InitialViewModel.swift
//  Chantine
//
//  Created by Beatriz Carlos on 25/11/20.
//

import UIKit

class InitialViewModel: InitialViewModelProtocol {
    var dataSource: [HabitBindingData]
    var habitRepository: HabitRepository
    
    static let initialViewModel = InitialViewModel()
    
    private init () {
        self.dataSource = []
        self.habitRepository = HabitRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)
        biding()
    }
    
    func numberOfRows() -> Int {
        return dataSource.count
    }
    
    func getCellData(forIndex index: Int) -> HabitBindingData {
        return dataSource[index]
    }
    
    func biding() {
        let habitCoreData = self.habitRepository.getTodayHabits()
        for habit in habitCoreData {
            let arrayProgress =  habit.currentProgress!
            let grouped = (arrayProgress.filter { $0 == 1}.count)
            var lightColor: UIColor = .white
            var darkColor: UIColor = .blackColor
            switch Int(habit.imageID) {
            case 1:
                lightColor = .blueLightColor
                darkColor = .blueDarkColor
            case 2:
                lightColor = .greenLightColor
                darkColor = .greenDarkColor
            case 3:
                lightColor = .yellowLightColor
                darkColor = .yellowDarkColor
            case 4:
                lightColor = .lavenderLightColor
                darkColor = .lavenderDarkColor
            default:
                lightColor = .white
                darkColor = .blackColor
            }
            
            dataSource.append(HabitBindingData(identifier: habit.identifier!, title: habit.title!, description: habit.goal!, imageId: Int(habit.imageID), bgcolor: lightColor, bgcolorDark: darkColor, progress: Float(grouped) / Float(arrayProgress.count)))
        }
    }
}
