//
//  SearchPageViewModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import RxSwift
import RxRelay

class SearchPageViewModel {
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - UseCase
    private let searchArticle: SearchArticleUseCase = SearchArticleUseCase()
    
    let error: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let loading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let contents: BehaviorRelay<[ArticleModel] > = BehaviorRelay(value: [])
    
    var isEmpty: Bool { return contents.value.isEmpty }
    var query: String = ""
    
    init(){

    }
    
}

// MARK: - INPUT. View event methods
extension SearchPageViewModel {
    func viewDidLoad() {
        load()
    }
    
    private func load() {
        
    }
    
    func searchTextFieldEmptry() {
        contents.accept([])
    }
    
    func search(_ query: String){
        self.query = query
        if error.value != nil {
            error.accept(nil)
        }
        loading.accept(true)
        searchArticle.execute((query: query,
                               begin_date: Date().addChangeDateTime(year: -10).customDateFormat("yyyyMMdd"),
                               end_date: Date().customDateFormat("yyyyMMdd"),
                               sort: .newest,
                               page: 0))
            .subscribe({ (event) in
                self.loading.accept(false)
                switch event {
                case .next(let items):
                    self.contents.accept(items)
                case .error(let error):
                    self.error.accept(error.localizedDescription)
                case .completed:
                    break
                }
            }).disposed(by: disposeBag)
    }
    
}

// MARK: - OUTPUT
extension SearchPageViewModel {
    
    func openDetailPage(info: ArticleModel){
        let model = DetailWebViewModel(strURL: info.url)
        let vc = DetailWebView.create(with: model)
        AppGlobal.shared.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSearchResultsPage(){
        let model = SearchResultsViewModel(query: query)
        let vc = SearchResultsView.create(with: model)
        AppGlobal.shared.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchSuggestion(_ query: String) {
        //loadSuggest(query: query)
    }

}
