//
//  CalendarViewDayCell.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class CalendarViewDayCell: UICollectionViewCell {

    public static let identifier = "CalendarViewDayCell"

    public var day: CalendarDayData?

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .roundedFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10

        self.addSubview(numberLabel)
        numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    public func configure(with data: CalendarDayData) {
        self.numberLabel.text = data.day
        self.backgroundColor = .carrotOrange
        if data.isHighlighted {
            self.numberLabel.tintColor = .white
            if let calendarView = superview as? CalendarView {
                self.backgroundColor = calendarView.highlightedColor
            }
        }

        if data.isDisabled {
            self.tintColor = .systemGray
            self.backgroundColor = .systemGray4
        }
    }
}
