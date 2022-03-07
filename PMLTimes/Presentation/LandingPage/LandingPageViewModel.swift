//
//  LandingPageViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation

class LandingPageViewModel {
    
    enum PageState {
        case idle
        case loaded
    }
    
    private let authUseCase: AuthenticationUseCase = AuthenticationUseCaseImpl()
    private var state: PageState = .idle
    init(){}
    
    func load(){
        authUseCase.execute(){ service, _  in
            guard let service = service else { return }
            AppGlobal.shared.service = service
            self.openHomePage()
        }
    }
    
    func openHomePage(){
        guard state == .idle else { return }
        let model = HomePageViewModel()
        let vc = HomePageView.create(with: model)
        AppGlobal.shared.navigationController?.pushViewController(vc, animated: false)
    }
}


