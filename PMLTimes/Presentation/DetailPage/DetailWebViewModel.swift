//
//  DetailWebViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import RxSwift
import RxRelay

class DetailWebViewModel {
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    
    var strURL: String
    let error: BehaviorRelay<String> = BehaviorRelay(value: "")
    let loading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    init(strURL: String){
        self.strURL = strURL
    }
    
    func load(){
        loading.accept(true)
    }
    
}
