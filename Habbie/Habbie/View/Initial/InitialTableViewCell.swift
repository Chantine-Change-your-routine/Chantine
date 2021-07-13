//
//  InitialTableViewCell.swift
//  Chantine
//
//  Created by Beatriz Carlos on 24/11/20.
//

import UIKit

class InitialTableViewCell: UITableViewCell {
    var cellView: CardComponentView = {
        let view = CardComponentView(type: .checkable)
        return view
    }()
    
    var identifier: String {
        didSet {
            cellView.identifier = identifier
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.identifier = ""
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        cellView.identifier = self.identifier
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: HabitBindingData) {
        cellView.setData(data)
        cellView.identifier = self.identifier
    }
    
    func setup() {
        backgroundView = UIView(frame: .zero)
        backgroundColor = .clear
        
        contentView.addSubview(cellView)
        addFullSizeConstraints(toView: cellView)
    }
}
