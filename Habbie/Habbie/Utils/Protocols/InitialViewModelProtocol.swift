//
//  InitialViewModelProtocol.swift
//  Chantine
//
//  Created by Beatriz Carlos on 25/11/20.
//

import Foundation
import UIKit

protocol InitialViewModelProtocol {
    var dataSource: [HabitBindingData] { get set }
    var habitRepository: HabitRepository { get }
    
    func numberOfRows() -> Int
    func getCellData(forIndex index: Int) -> HabitBindingData
    func biding()
}
