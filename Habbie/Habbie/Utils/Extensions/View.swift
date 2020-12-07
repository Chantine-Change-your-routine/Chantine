//
//  View.swift
//  Chantine
//
//  Created by Beatriz Carlos on 25/11/20.
//

import Foundation
import UIKit

extension UIView {
    func addFullSizeConstraints(toView view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            view.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
}
