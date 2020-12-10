//
//  ModalAvatarCollectionViewCell.swift
//  Habbie
//
//  Created by Beatriz Carlos on 09/12/20.
//

import UIKit

class ModalAvatarCollectionViewCell: UICollectionViewCell {
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    func setupUI() {
        
    }
}
