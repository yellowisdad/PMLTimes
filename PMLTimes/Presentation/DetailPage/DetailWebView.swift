//
//  DetailWebView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit
import WebKit
import RxSwift

class DetailWebView: BaseViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    private var viewModel: DetailWebViewModel!
    
    fileprivate var disposeBag = DisposeBag()
    
    static func create(with viewModel: DetailWebViewModel) -> UIViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailWebView") as? DetailWebView else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(Self.description())")
        }
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.tintColor = .black
        
        bind(to: viewModel)
        viewModel.load()
    }

    private func bind(to viewModel: DetailWebViewModel) {
        viewModel.loading.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(onNext: { isLoading in
                if isLoading {
                    if let url = URL(string: viewModel.strURL) {
                        self.webView.load(URLRequest(url: url))
                    } else {
                        print("error")
                    }
                } else {
                    
                }
            }).disposed(by: disposeBag)
    }
}

