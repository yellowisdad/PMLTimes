//
//  SearchResultsViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import RxSwift
import RxRelay

enum State {
    case idle
    case loading
    case loaded
    case error(e: Error)
    case emptry
}

class SearchResultsViewModel {
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - UseCase
    private let searchArticle: GetSearchArticleUseCase = GetSearchArticleUseCaseImpl()
    
    let state: BehaviorRelay<State> = BehaviorRelay(value: .idle)
    let isSpinning: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let page: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let newContent: BehaviorRelay<[ArticleModel]> = BehaviorRelay(value: [])
    var allContents: [ArticleModel] = []
    
    fileprivate let length = 10
    fileprivate var isLoadMoreEnable = true
    var isCanLoadmore: Bool {
        switch state.value {
        case .loaded:
            return isLoadMoreEnable
        default :
            return false
        }
    }
    
    
    var beginDate: Date = Date().addChangeDateTime(year: -10)
    var endDate: Date = Date()
    var query: String = ""
    var sort: SearchSort = .newest
    
    
    init(query: String){
        self.query = query
        page
            .subscribe(onNext: { _ in
                self.load()
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - INPUT. View event methods
extension SearchResultsViewModel {
    func viewDidLoad() {
        isSpinning.accept(true)
        load()
    }
    
    private func load() {
        search(query)
    }
    
    func search(_ query: String){
        self.query = query
        state.accept(.loading)
        
        searchArticle.execute(query: query,
                              begin_date: beginDate.customDateFormat("yyyyMMdd"),
                              end_date: endDate.customDateFormat("yyyyMMdd"),
                              sort: sort,
                              page: page.value)
            .subscribe({ (event) in
                
                switch event {
                case .next(let items):
                    self.state.accept(.loaded)
                    self.newContent.accept(items)
                    self.isLoadMoreEnable = items.count == self.length
                    
                case .error(let error):
                    self.state.accept(.error(e: error))
                    self.isLoadMoreEnable = false
                    
                case .completed:
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    func resetPage() {
        isLoadMoreEnable = true
        page.accept(0)
    }
    
}

// MARK: - OUTPUT
extension SearchResultsViewModel {
    
    func openDetailPage(info: ArticleModel){
        let model = DetailWebViewModel(strURL: info.url)
        let vc = DetailWebView.create(with: model)
        AppGlobal.shared.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openFilterPage(){
        let model = FilterPageViewModel(beginDate: beginDate, endDate: endDate, sort: sort)
        model.changeFilter
            .subscribe(onNext: { (sort, beginDate, endDate) in
                self.sort = sort
                self.beginDate = beginDate
                self.endDate = endDate
                self.isSpinning.accept(true)
                self.load()
            })
            .disposed(by: disposeBag)
        
        let vc = FilterPageView.create(with: model)
        vc.modalPresentationStyle = .fullScreen
        AppGlobal.shared.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}
