//
//  CalendarDayView.swift
//  Chantine
//
//  Created by Pedro Sousa on 24/11/20.
//

import UIKit

enum DayViewStyle {
    case normal
    case highlighted
    case disabled
}

class CalendarDayView: UIView {

    public var text: String? {
        didSet {
            self.dayLabel.text = text
        }
    }

    private var dayLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .red
        label.textAlignment = .center
        return label
    }()

    init(size: CGSize, style: DayViewStyle) {
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.setStyle(style: style)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.layer.cornerRadius = 10
        self.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true

        self.addSubview(dayLabel)
        dayLabel.font = .roundedFont(ofSize: self.frame.height * 0.5, weight: .semibold)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    private func setStyle(style: DayViewStyle) {
        switch style {
        case .normal:
            self.dayLabel.textColor = .label
            self.backgroundColor = .clear
        case .highlighted:
            self.dayLabel.textColor = .white
            self.backgroundColor = .carrotOrange
        case .disabled:
            self.dayLabel.textColor = .systemGray
            self.backgroundColor = .systemGray6
        }
    }
}
