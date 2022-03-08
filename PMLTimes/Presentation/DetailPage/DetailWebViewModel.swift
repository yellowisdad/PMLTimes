//
//  DetailWebViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import RxSwift

class DetailWebViewModel {
    
    var strURL: String
    let loading = PublishSubject<Bool>()
    
    init(strURL: String){
        self.strURL = strURL
    }
    
    func load(){
        loading.onNext(true)
    }
    
}
