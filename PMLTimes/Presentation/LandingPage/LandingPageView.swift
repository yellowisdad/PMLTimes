//
//  LandingPageView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit

class LandingPageView: UIViewController {

    private var viewModel = LandingPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }

}

