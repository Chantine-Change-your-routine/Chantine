//
//  InitialViewModelProtocol.swift
//  Chantine
//
//  Created by Beatriz Carlos on 25/11/20.
//

import Foundation
import UIKit

struct HabitBindingData {
    let identifier: String
    let title: String
    let description: String
    let imageId: Int
    let bgcolor: UIColor
    let bgcolorDark: UIColor
    let progress: Float
}

protocol InitialViewModelProtocol {
    var dataSource: [HabitBindingData] { get set }
//    var habitRepository: HabitRepository { get }
    
    func numberOfRows() -> Int
    func getCellData(forIndex index: Int) -> HabitBindingData
//    func biding() -> HabitBindingData
}
