//
//  ViewController.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppGlobal.shared.fechFirestore { fechSuccess in
            if fechSuccess {
                let model = HomePageViewModel()
                let vc = HomePageView.create(with: model)
                AppGlobal.shared.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }

}

