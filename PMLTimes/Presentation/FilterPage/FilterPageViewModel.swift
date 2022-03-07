//
//  FilterPageViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import RxSwift
import RxRelay

class FilterPageViewModel {
    private var disposeBag: DisposeBag = DisposeBag()
    
    var beginDate: Date
    var endDate: Date
    var sort: SearchSort
    
    public let changeFilter = PublishSubject<(SearchSort, Date, Date)>()
    
    init(beginDate: Date, endDate: Date, sort: SearchSort){
        self.beginDate = beginDate
        self.endDate = endDate
        self.sort = sort
    }
    
    func sendFilter(){
        changeFilter.onNext((sort, beginDate, endDate))
    }
}
