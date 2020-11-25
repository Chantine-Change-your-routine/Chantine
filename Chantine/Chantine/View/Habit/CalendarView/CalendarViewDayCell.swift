//
//  CalendarViewDayCell.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class CalendarViewDayCell: UICollectionViewCell {

    public static let identifier = "CalendarViewDayCell"

    private lazy var dayLabel: UILabel = {
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

        self.addSubview(dayLabel)
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    public func configure(text: String, style: DayViewStyle) {
        self.dayLabel.text = text
        self.setStyle(style: style)
    }

    private func setStyle(style: DayViewStyle) {
        switch style {
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
