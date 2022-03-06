//
//  SearchPageView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit
import RxSwift

class SearchPageView: BaseViewController, UIScrollViewDelegate {
    
    enum SearchPageSection {
        case suggest
        case preview
        case goSearch
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBGView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emtryLabel: UILabel!
    fileprivate var disposeBag = DisposeBag()
    
    private var viewModel: SearchPageViewModel!
    private var pageSections: [SearchPageSection] = [.suggest, .goSearch, .preview]
    
    static func create(with viewModel: SearchPageViewModel) -> UIViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchPageView") as? SearchPageView else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(Self.description())")
        }
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        setupView()
        viewModel.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension SearchPageView {
    
    func setupView() {
        
        spinner.hidesWhenStopped = true
        searchBGView.circleCorner = true
        textField.enablesReturnKeyAutomatically = true
        
        registerTableView()
    }
    
    func registerTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.top = 10
        
        // MARK: - Cell
        tableView.register(UINib(nibName: "ContentSearchTableViewCell",
                                 bundle: nil),
                                 forCellReuseIdentifier: "ContentSearchViewCell")
        
    }
    
    private func bind(to viewModel: SearchPageViewModel) {
        
        textField.rx.controlEvent(.editingChanged)
            .debounce(.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                guard let text = self.textField.text, text != "" else {
                    self.viewModel.query = ""
                    self.viewModel.searchTextFieldEmptry()
                    return
                }
                self.viewModel.search(text)
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] in
                guard let text = self.textField.text, text != "" else { return }
                self.viewModel.query = text
                self.viewModel.openSearchResultsPage()
            })
            .disposed(by: disposeBag)
        
        viewModel.contents.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(onNext: { content in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.loading.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(onNext: { isLoading in
                if !isLoading {
                    self.tableView.finishInfiniteScroll()
                }
            }).disposed(by: disposeBag)
        
//        viewModel.loading.asObservable()
//            .observeOn(MainScheduler.instance)
//            .bind(to: spinner.rx.isAnimating)
//            .disposed(by: disposeBag)
        
        viewModel.error.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(onNext: { errorMsg in
                self.emtryLabel.text = errorMsg
                self.emtryLabel.isHidden = errorMsg == nil
            }).disposed(by: disposeBag)
    }
}


extension SearchPageView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch pageSections[indexPath.section] {
        case .suggest:
            break
        case .preview:
            viewModel.openDetailPage(info: viewModel.contents.value[indexPath.row])
        case .goSearch:
            viewModel.openSearchResultsPage()
        }
    }
}

extension SearchPageView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return pageSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch pageSections[section] {
        case .suggest:
            return 0
        case .preview:
            return viewModel.contents.value.count
        case .goSearch:
            return viewModel.query.isEmpty ? 0 : 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch pageSections[indexPath.section] {
        case .suggest:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "suggestSearchCell", for: indexPath) as? SuggestTableViewCell else { return UITableViewCell() }
            return cell
            
        case .goSearch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "suggestSearchCell", for: indexPath) as? SuggestTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = "go to \"\(viewModel.query)\""
            return cell
            
        case .preview:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentSearchViewCell", for: indexPath) as? ContentSearchTableViewCell else { return UITableViewCell() }
            let info = viewModel.contents.value[indexPath.row]
            cell.contentImageView.setImage(info.media.last?.url ?? "")
            cell.titleLabel.text = info.title
            cell.bylineLabel.text = info.byline
            return cell
        }
    }


}

extension SearchPageView {
    
    @IBAction func closeButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }

}



