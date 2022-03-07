//
//  DetailWebView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit
import WebKit

class DetailWebView: BaseViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var webView: WKWebView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
        webView.load(URLRequest(url: URL(string: "https://www.google.com/")!))
        
        self.navigationController?.hidesBarsOnSwipe = true
//        self.navigationItem.setHidesBackButton(true, animated: true);
//        self.navigationItem.title = "dddjeroghierhgeroghuerhguerhgoherugheuorhguo"
        navigationItem.backButtonTitle = ""
//        let backBarButtonItem = UIBarButtonItem(title: "You back button title here", style: .plain, target: nil, action: nil)
//                navigationItem.backBarButtonItem = backBarButtonItem
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
//    }


}

