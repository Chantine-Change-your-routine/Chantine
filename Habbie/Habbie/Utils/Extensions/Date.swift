//
//  Date.swift
//  Habbie
//
//  Created by Beatriz Carlos on 09/12/20.
//

import Foundation

extension Date {
    static let formatterDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        return formatter
    }()
    var formattedDate: String {
        return Date.formatterDate.string(from: self)
    }
    
    static let formatterTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    var formattedTime: String {
        return Date.formatterTime.string(from: self)
    }
}
