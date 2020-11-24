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

    public var dataSource: UICollectionViewDataSource? {
        didSet {
            self.currentMonthView.dataSource = self.dataSource
        }
    }

    public var delegate: UICollectionViewDelegate? {
        didSet {
            self.currentMonthView.delegate = self.delegate
        }
    }

    private static let layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 35, height: 35)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        return layout
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Janeiro, 2020"
        label.font = .roundedFont(ofSize: 17, weight: .semibold)
        label.tintColor = .label
        return label
    }()

    private var currentMonthView: UICollectionView

    init(width: CGFloat, highlightedRanges: [ClosedRange<Int>]) {
        self.currentMonthView = CalendarView.generateDaysCollection()

        super.init(frame: .zero)
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
        titleLabel.font = .roundedFont(ofSize: proportionalSize(20), weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: proportionalSize(20)).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        let weekdayStack = generateWeekdayStack()
        self.addSubview(weekdayStack)
        weekdayStack.translatesAutoresizingMaskIntoConstraints = false
        weekdayStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: proportionalSize(20)).isActive = true
        weekdayStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: proportionalSize(-20)).isActive = true
        weekdayStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true

        self.addSubview(currentMonthView)
        currentMonthView.translatesAutoresizingMaskIntoConstraints = false
        currentMonthView.widthAnchor.constraint(equalToConstant: 305).isActive = true
        currentMonthView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        currentMonthView.topAnchor.constraint(equalTo: weekdayStack.bottomAnchor, constant: 10).isActive = true
        currentMonthView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }

    private static func generateDaysCollection() -> UICollectionView {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: CalendarView.layout)
        collection.backgroundColor = .clear
        collection.register(CalendarViewDayCell.self, forCellWithReuseIdentifier: CalendarViewDayCell.identifier)
        return collection
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

    private func generateMonth() -> UIStackView {
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

        for i in offsetPastMonth...0 {
            days.append(generateDayView(number: lastDayPastMonth - i, style: .disabled))
        }

        for i in 1...numberOfDays {
            days.append(generateDayView(number:  i, style: .normal))
        }

        for i in 1...offsetNextMonth {
            days.append(generateDayView(number: i, style: .disabled))
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
        return value * self.frame.width / 335
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CalendarViewDayCell.identifier,
                for: indexPath) as? CalendarViewDayCell else {
            return CalendarViewDayCell()
        }
//        cell.configure(text: indexPath.row, style: )
        return cell
    }
}
