//
//  InitialModalViewController.swift
//  Habbie
//
//  Created by Brena Amorim on 13/07/21.
//

import UIKit

class InitialModalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = UIView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: -self.view.frame.height))
        newView.backgroundColor = .yellow
        newView.layer.cornerRadius = 20

        self.view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))

        // self.view is now a transparent view, so now I add newView to it and can size it however, I like.

        self.view.addSubview(newView)

        // works without the tap gesture just fine (only dragging), but I also wanted to be able to tap anywhere and dismiss it, so I added the gesture below
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }

}
