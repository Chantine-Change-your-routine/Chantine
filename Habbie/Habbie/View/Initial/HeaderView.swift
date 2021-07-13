//
//  HeaderView.swift
//  Chantine
//
//  Created by Beatriz Carlos on 25/11/20.
//

import UIKit

class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabelHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedFont(ofSize: 22, weight: .bold)
        label.textColor = .blackColor
        return label
    }()
    
    func setupHeader() {
        self.addSubview(titleLabelHeader)
        NSLayoutConstraint.activate([
            titleLabelHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabelHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabelHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
