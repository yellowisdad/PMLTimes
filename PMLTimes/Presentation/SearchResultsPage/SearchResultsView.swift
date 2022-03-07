//
//  SearchResultsView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit
import RxSwift
import UIScrollView_InfiniteScroll

class SearchResultsView: BaseViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var searchBGView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emtryLabel: UILabel!
    
    private var topRefreshControl: UIRefreshControl?
    fileprivate var disposeBag = DisposeBag()
    
    
    private var viewModel: SearchResultsViewModel!
    
    static func create(with viewModel: SearchResultsViewModel) -> UIViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsView") as? SearchResultsView else {
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension SearchResultsView {
    
    func setupView() {
        
        spinner.hidesWhenStopped = true
        searchBGView.circleCorner = true
        
        registerTableView()
    }
    
    func registerTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.top = 10
        
        addTopRefresh()
        
        tableView.register(UINib(nibName: "ContentItemTableViewCell",
                                 bundle: nil),
                                 forCellReuseIdentifier: "ContentItemCell")
        
        tableView.addInfiniteScroll { (_) -> Void in
            self.viewModel.page.accept(self.viewModel.page.value + 1)
        }
        tableView.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return self.viewModel.isCanLoadmore
        }
        
    }
    
    private func bind(to viewModel: SearchResultsViewModel) {
        searchLabel.text = viewModel.query
        
        viewModel.newContent.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(onNext: { content in
                if viewModel.page.value == 0 {
                    self.viewModel.allContents = content
                    self.tableView.reloadData()
                } else {
                    let previousCount = self.viewModel.allContents.count
                    self.viewModel.allContents += content
                    self.tableView.insertMultipleRows(previousCount: previousCount, updateCount: self.viewModel.allContents.count)
                }
                if self.viewModel.allContents.count == 0 {
                    self.viewModel.state.accept(.emptry)
                }
            }).disposed(by: disposeBag)
        
        viewModel.isSpinning.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.state.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(onNext: { state in
                self.emtryLabel.isHidden = true
                switch state {
                case .idle:
                    break
                case .loading:
                    break
                case .loaded:
                    self.topRefreshControl?.endRefreshing()
                    self.tableView.finishInfiniteScroll()
                    if viewModel.isSpinning.value {
                        viewModel.isSpinning.accept(false)
                    }
                case .error(let error):
                    self.emtryLabel.text = error.localizedDescription
                    self.emtryLabel.isHidden = false
                    if self.viewModel.allContents.count > 0 {
                        self.viewModel.allContents = []
                    }
                case .emptry:
                    self.emtryLabel.text = "no results for \"\(self.viewModel.query)\" in the period."
                    self.emtryLabel.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
    
    func addTopRefresh() {
        topRefreshControl = UIRefreshControl()
        topRefreshControl!.addTarget(self, action: #selector(self.topRefresh(_:)), for: .valueChanged)
        tableView.addSubview(topRefreshControl!)
    }
    
}


extension SearchResultsView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openDetailPage(info: viewModel.allContents[indexPath.row])
    }
}

extension SearchResultsView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allContents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentItemCell", for: indexPath) as? ContentItemTableViewCell else { return UITableViewCell() }
        let info = self.viewModel.allContents[indexPath.row]
        cell.contentImageView.setImage(info.media.last?.url ?? "")
        cell.titleLabel.text = info.title
        cell.sectionLabel.text = info.section
        cell.bylineLabel.text = info.byline
        cell.abstractLabel.text = info.abstract
        cell.publishedDateLabel.text = info.publishedDate?.customDateFormat("dd MMM yy") ?? ""
        return cell
    }


}

extension SearchResultsView {
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func filterButtonTap(_ sender: Any) {
        viewModel.openFilterPage()
    }
    
    @objc private func topRefresh(_ sender: AnyObject) {
        viewModel.resetPage()
    }
}
