//
//  MainViewController.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goToHabitView(_ sender: Any) {
        let controller = HabitViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
