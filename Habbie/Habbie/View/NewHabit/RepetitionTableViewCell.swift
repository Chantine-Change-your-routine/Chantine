//
//  RepetitionTableViewCell.swift
//  Habbie
//
//  Created by José Mateus Azevedo on 09/12/20.
//

import UIKit

class RepetitionTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "RepetitionTableViewCell")
        self.selectionStyle = .none
        setLabelConstraints()

    }

    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .roundedFont(ofSize: 16, weight: .regular)
        label.textColor = .blackColor
        label.textAlignment = .left

        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
        // Configure the view for the selected state
    }

    func setLabelConstraints() {
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
