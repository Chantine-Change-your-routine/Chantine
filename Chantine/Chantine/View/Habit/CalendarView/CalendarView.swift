//
//  CalendarView.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class CalendarView: UIView {
    private let calendar = Calendar.current
    private let today = Date()

    public var normalColor: UIColor = .white
    public var highlightedColor: UIColor = .systemBlue

    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Janeiro, 2020"
        label.font = .roundedFont(ofSize: 17, weight: .semibold)
        label.tintColor = .label
        return label
    }()

    private let gauge: CGFloat

    init(width: CGFloat, highlightedRanges: [ClosedRange<Int>]) {

        self.gauge = width

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: width * 1.074).isActive = true

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = self.normalColor
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.1

        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: proportionalSize(20)).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        let weekdayStack = generateWeekdayStack()
        self.addSubview(weekdayStack)
        weekdayStack.translatesAutoresizingMaskIntoConstraints = false
        weekdayStack.leftAnchor.constraint(equalTo: self.leftAnchor,
                                           constant: proportionalSize(20)).isActive = true
        weekdayStack.rightAnchor.constraint(equalTo: self.rightAnchor,
                                            constant: proportionalSize(-20)).isActive = true
        weekdayStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true

        let monthStack = generateMonthStack()
    }

    private func generateWeekdayStack() -> UIStackView {
        let days = ["S", "T", "Q", "Q", "S", "S", "D"]

        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 10

        for day in days {
            let label = UILabel(frame: .zero)
            label.widthAnchor.constraint(equalToConstant: proportionalSize(35)).isActive = true
            label.heightAnchor.constraint(equalToConstant: proportionalSize(35)).isActive = true
            label.text = day
            label.font = .roundedFont(ofSize: proportionalSize(17), weight: .semibold)
            label.textAlignment = .center
            stack.addArrangedSubview(label)
        }
        return stack
    }

    private func generateMonthStack() -> UIStackView {
        let monthStack = UIStackView()
        monthStack.axis = .vertical
        monthStack.spacing = 10
        monthStack.alignment = .center
        monthStack.distribution = .equalSpacing

        let numberOfDays = calendar.numberOfDays()
        let firstWeekDay = calendar.firstWeekdayOfMonth()
        let offsetPastMonth = 7 - firstWeekDay
        let offsetNextMonth = 42 - (offsetPastMonth + numberOfDays)
        let lastDayPastMonth = calendar.lastDayOfPastMonth()

        var days = [CalendarDayView]()

        if offsetPastMonth > 0 {
            for i in 1...offsetPastMonth {
                days.append(generateDayView(number: lastDayPastMonth - (offsetPastMonth - i), style: .disabled))
            }
        }

        for i in 1...numberOfDays {
            days.append(generateDayView(number:  i, style: .normal))
        }

        if offsetNextMonth > 0 {
            for i in 1...offsetNextMonth {
                days.append(generateDayView(number: i, style: .disabled))
            }
        }

        return monthStack
    }

    private func generateWeekStack() -> UIStackView {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = proportionalSize(10)
        return stack
    }

    private func generateDayView(number: Int, style: DayViewStyle) -> CalendarDayView {
        let side = proportionalSize(35)
        let dayView = CalendarDayView(size: CGSize(width: side, height: side))
        dayView.text = String(number)
        dayView.style = style
        return dayView
    }

    public func proportionalSize(_ value: CGFloat) -> CGFloat {
        let proportionalSize = CGFloat.rounded((value * (self.gauge/374)))()
        if self.gauge/374 >= 0.9 {
            return proportionalSize
        } else {
            return CGFloat.rounded(proportionalSize * 0.9)()
        }
    }
}
