//
//  CalendarView.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class CalendarView: UIView {
    private let calendar = Calendar.current

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

    init(size: CGSize) {
        let collectionSize = CGSize(width: size.width * 0.91, height: size.height * 72)
        self.currentMonthView = CalendarView.generateDaysCollection(size: collectionSize)

        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))

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

        let width = UIScreen.main.bounds.width - 40
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: width * 1.07).isActive = true

        self.addSubview(titleLabel)
        titleLabel.font = .roundedFont(ofSize: 17, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        let weekdayStack = generateWeekdayStack()
        self.addSubview(weekdayStack)
        weekdayStack.translatesAutoresizingMaskIntoConstraints = false
        weekdayStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        weekdayStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        weekdayStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true

        self.addSubview(currentMonthView)
        currentMonthView.translatesAutoresizingMaskIntoConstraints = false
        currentMonthView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        currentMonthView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        currentMonthView.topAnchor.constraint(equalTo: weekdayStack.bottomAnchor, constant: 10).isActive = true
        currentMonthView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    private static func generateDaysCollection(size: CGSize) -> UICollectionView {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let collection = UICollectionView(frame: frame, collectionViewLayout: CalendarView.layout)
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
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
            label.text = day
            label.font = .roundedFont(ofSize: 17, weight: .semibold)
            stack.addArrangedSubview(label)
        }
        return stack
    }
}
