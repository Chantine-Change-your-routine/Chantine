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

    private let proportion: CGFloat
    private var highlightedDaysRanges: [ClosedRange<Int>]

    init(width: CGFloat, highlightedDaysRanges: [ClosedRange<Int>]) {
        self.highlightedDaysRanges = highlightedDaysRanges
        self.proportion = 374 / 374

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        let height = (proportion == 1) ? width : width + 20
        self.heightAnchor.constraint(equalToConstant: height).isActive = true

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.2

        self.addSubview(titleLabel)
        titleLabel.text = "\(calendar.monthName()), \(calendar.currentYear)"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: proportionalSize(20)).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        let weekdayStack = generateWeekdayStack()
        self.addSubview(weekdayStack)
        weekdayStack.translatesAutoresizingMaskIntoConstraints = false
        weekdayStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                          constant: 10).isActive = true
        weekdayStack.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true

        let monthStack = generateMonthStack()
        self.addSubview(monthStack)
        monthStack.translatesAutoresizingMaskIntoConstraints = false
        monthStack.topAnchor.constraint(equalTo: weekdayStack.bottomAnchor,
                                        constant: proportionalSize(10)).isActive = true
        monthStack.leftAnchor.constraint(equalTo: weekdayStack.leftAnchor).isActive = true
        monthStack.rightAnchor.constraint(equalTo: weekdayStack.rightAnchor).isActive = true
    }

    private func generateWeekdayStack() -> UIStackView {
        let days = ["S", "T", "Q", "Q", "S", "S", "D"]

        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = proportionalSize(12)

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
        monthStack.backgroundColor = .clear
        monthStack.axis = .vertical
        monthStack.alignment = .center
        monthStack.distribution = .equalSpacing
        monthStack.spacing = 10

        let numberOfDays = calendar.numberOfDays()
        let firstWeekDay = calendar.firstWeekdayOfMonth()
        let offsetPastMonth = 7 - firstWeekDay
        let offsetNextMonth = 42 - (offsetPastMonth + numberOfDays)
        let lastDayPastMonth = calendar.lastDayOfPastMonth()

        var days: [CalendarDayView] = []

        if offsetPastMonth > 0 {
            for offsetDay in 1...offsetPastMonth {
                days.append(generateDayView(number: lastDayPastMonth - (offsetPastMonth - offsetDay), style: .disabled))
            }
        }

        for numberOfDay in 1...numberOfDays {
            var style: DayViewStyle = .normal

            if shouldBeHghlighted(day: numberOfDay) {
                style = .highlighted
            }

            days.append(generateDayView(number: numberOfDay, style: style))
        }

        if offsetNextMonth > 0 {
            for offsetDay in 1...offsetNextMonth {
                days.append(generateDayView(number: offsetDay, style: .disabled))
            }
        }

        while days.count > 6 {
            let thisWeek = Array(days[0...6])
            days.removeFirst(7)
            let weekStack = generateWeekStack(daysViews: thisWeek)
            monthStack.addArrangedSubview(weekStack)
        }

        return monthStack
    }

    private func generateWeekStack(daysViews: [CalendarDayView]) -> UIStackView {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = proportionalSize(12)

        for dayView in daysViews {
            stack.addArrangedSubview(dayView)
        }

        return stack
    }

    private func generateDayView(number: Int, style: DayViewStyle) -> CalendarDayView {
        let side = proportionalSize(35)
        let dayView = CalendarDayView(size: CGSize(width: side, height: side),
                                      style: style)
        dayView.text = String(number)
        return dayView
    }

    public func proportionalSize(_ value: CGFloat) -> CGFloat {
        if self.proportion >= 0.9 {
            return value
        } else if self.proportion <= 0.6 {
            return CGFloat.rounded(value * 0.75)()
        } else {
            return CGFloat.rounded(value * 0.9)()
        }
    }

    private func shouldBeHghlighted(day: Int) -> Bool {
        var range = self.highlightedDaysRanges
        while range.count > 0 {
            guard let max = range[0].max() else { return false }
            if range[0].contains(day) && day <= Int(max) {
                return true
            } else {
                range.removeFirst()
            }
        }
        return false
    }
}
