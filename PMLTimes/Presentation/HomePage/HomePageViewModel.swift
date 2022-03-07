//
//  HomePageViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import RxSwift
import RxRelay

class HomePageViewModel {
    
    enum State {
        case idle
        case loading
        case loaded
        case error(e: Error)
        case emptry
    }
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    private let getMostPopularUseCase: GetMostPopularArticleUseCase
    let isSpinning: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let period: BehaviorRelay<MostPopularPeriod> = BehaviorRelay(value: .day)
    let contents: BehaviorRelay<[ArticleModel]> = BehaviorRelay(value: [])
    let state: BehaviorRelay<State> = BehaviorRelay(value: .idle)
    
    init(getMostPopular: GetMostPopularArticleUseCase = GetMostPopularArticleUseCaseImpl()){
        self.getMostPopularUseCase = getMostPopular
        
        period
            .subscribe(onNext: { _ in
                self.getMostPopular()
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - INPUT. View event methods
extension HomePageViewModel {
    func viewDidLoad() {
        isSpinning.accept(true)
        getMostPopular()
    }
    
    func getMostPopular(){
        state.accept(.loading)
            
            getMostPopularUseCase.execute(period.value)
                .subscribe({ (event) in
                    
                    switch event {
                    case .next(let items):
                        self.state.accept(.loaded)
                        self.contents.accept(items)
                        
                    case .error(let error):
                        self.state.accept(.error(e: error))
                        
                    case .completed:
                        break
                    }
                }).disposed(by: disposeBag)
    }
    
    func reloadPage(){
        getMostPopular()
    }
    
}

// MARK: - OUTPUT
extension HomePageViewModel {
    
    func openDetailPage(info: ArticleModel){
        let model = DetailWebViewModel(strURL: info.url)
        let vc = DetailWebView.create(with: model)
        AppGlobal.shared.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSearchPage(){
        let model = SearchPageViewModel()
        let vc = SearchPageView.create(with: model)
        vc.modalPresentationStyle = .fullScreen
        AppGlobal.shared.navigationController?.pushViewController(vc, animated: false)
    }
    
}
