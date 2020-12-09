//
//  ModalAvatarViewController.swift
//  Habbie
//
//  Created by Beatriz Carlos on 09/12/20.
//

import UIKit

class ModalAvatarViewController: UIViewController {
    lazy var modalView: ModalAvatarView = {
        let view = ModalAvatarView(frame: .zero)
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = modalView
    }
}

extension ModalAvatarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModalAvatarCollectionViewCell", for: indexPath) as? ModalAvatarCollectionViewCell else { return ModalAvatarCollectionViewCell() }
        return cell
    }
}
