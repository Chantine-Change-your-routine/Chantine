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

    var style: DayViewStyle = .normal {
        didSet {
            self.updateStyle()
        }
    }

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .label
        return label
    }()

    init(size: CGSize) {
        super.init(frame: .zero)

        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .clear

        self.addSubview(dayLabel)
        dayLabel.tintColor = .label
        dayLabel.font = .roundedFont(ofSize: self.frame.height * 0.5, weight: .semibold)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dayLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }

    private func updateStyle() {
        switch self.style {
        case .normal:
            if let superView = superview as? CalendarView {
                self.backgroundColor = superView.normalColor
            } else {
                self.backgroundColor = .clear
            }
            self.dayLabel.tintColor = .label
        case .highlighted:
            self.dayLabel.tintColor = .white
            if let superView = superview as? CalendarView {
                self.backgroundColor = superView.highlightedColor
            } else {
                self.backgroundColor = .systemBlue
            }
        case .disabled:
            self.dayLabel.tintColor = .systemGray
            self.backgroundColor = .systemGray4
        }
    }
}
