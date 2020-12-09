//
//  ModalAvatarViewController.swift
//  Habbie
//
//  Created by Beatriz Carlos on 09/12/20.
//

import UIKit

class ModalAvatarViewController: UIViewController {
    lazy var modalView: ModalAvatarView = {
        let view = ModalAvatarView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = modalView
    }
}
