//
//  EditDelegate.swift
//  Chantine
//
//  Created by José Mateus Azevedo on 26/11/20.
//

import Foundation

enum Pickers {
    case startDate
    case reminders
}

protocol EditDelegate: AnyObject {
    func showPicker(pickerName: Pickers)
}
