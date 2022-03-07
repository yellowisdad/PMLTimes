//
//  LandingPageViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation

class LandingPageViewModel {
    
    private let authUseCase: AuthenticationUseCase = AuthenticationUseCase()
    
    init(){}
    
    func load(){
        authUseCase.execute(){ service in
            guard let service = service else {
                return
            }
            AppGlobal.shared.service = service
            self.openHomePage()
        }
    }
    
    func openHomePage(){
        let model = HomePageViewModel()
        let vc = HomePageView.create(with: model)
        AppGlobal.shared.navigationController?.pushViewController(vc, animated: false)
    }
}


