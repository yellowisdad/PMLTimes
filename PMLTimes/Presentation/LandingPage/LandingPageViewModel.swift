//
//  LandingPageViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import RxRelay

class LandingPageViewModel {
    
    private let authUseCase: AuthenticationUseCase = AuthenticationUseCase()
    let state: BehaviorRelay<State> = BehaviorRelay(value: .idle)
    
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
        switch state.value {
        case .loaded:
            return
        default:
            state.accept(.loaded)
            let model = HomePageViewModel()
            let vc = HomePageView.create(with: model)
            AppGlobal.shared.navigationController?.pushViewController(vc, animated: false)
        }
    }
}


