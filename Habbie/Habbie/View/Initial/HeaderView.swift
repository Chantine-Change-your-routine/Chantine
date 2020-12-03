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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabelHeader: UILabel = {
        let label = UILabel()
        label.font = .roundedFont(ofSize: 22, weight: .bold)
        return label
    }()
}
