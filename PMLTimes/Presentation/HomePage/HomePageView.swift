//
//  HomePageView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit
import RxSwift
import RxDataSources

class HomePageView: BaseViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var topbarView: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    @IBOutlet weak var emtryLabel: UILabel!
    
    private var topRefreshControl: UIRefreshControl?
    fileprivate var disposeBag = DisposeBag()
    
    
    private var viewModel: HomePageViewModel!
    
    static func create(with viewModel: HomePageViewModel) -> UIViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePageView") as? HomePageView else {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension HomePageView {
    
    func setupView() {
        
        spinner.hidesWhenStopped = true
        topbarView.title = "The Pomelo Times"
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.title = "The Pomelo Times"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "chomsky", size: 30)!
        ]

        filterBarButton.tintColor = .black
        searchBarButton.tintColor = .black
        
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
        
        // MARK: - Cell
        tableView.register(UINib(nibName: "HighlightTableViewCell",
                                 bundle: nil),
                                 forCellReuseIdentifier: "HighlightCell")
        tableView.register(UINib(nibName: "ContentItemTableViewCell",
                                 bundle: nil),
                                 forCellReuseIdentifier: "ContentItemCell")
        
    }
    
    private func bind(to viewModel: HomePageViewModel) {
        
        switch viewModel.state {
        case .idle:
            break
        case .loading:
            emtryLabel.isHidden = true
            break
        case .loaded:
            self.topRefreshControl?.endRefreshing()
            if viewModel.isSpinning.value {
                viewModel.isSpinning.accept(false)
            }
            emtryLabel.isHidden = true
        case .error(let error):
            emtryLabel.text = error.localizedDescription
            emtryLabel.isHidden = false
            if self.viewModel.contents.value.count > 0 {
                self.viewModel.contents.accept([])
            }
        case .emptry:
            self.emtryLabel.text = "results not found"
            self.emtryLabel.isHidden = false
            
        }
        
        viewModel.contents.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(onNext: { content in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.isSpinning.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func addTopRefresh() {
        topRefreshControl = UIRefreshControl()
        topRefreshControl!.addTarget(self, action: #selector(self.topRefresh(_:)), for: .valueChanged)
        tableView.addSubview(topRefreshControl!)
    }
    
}


extension HomePageView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openDetailPage(info: viewModel.contents.value[indexPath.row])
    }
}

extension HomePageView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contents.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightCell", for: indexPath) as? HighlightTableViewCell else { return UITableViewCell() }
        let info = self.viewModel.contents.value[indexPath.row]
        cell.contentImageView.setImage(info.media.last?.url ?? "")
        cell.titleLabel.text = info.title
        cell.sectionLabel.text = info.section
        cell.bylineLabel.text = info.byline
        cell.abstractLabel.text = info.abstract
        cell.publishedDateLabel.text = info.publishedDate?.customDateFormat("dd MMM yy") ?? ""
        return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentItemCell", for: indexPath) as? ContentItemTableViewCell else { return UITableViewCell() }
            let info = self.viewModel.contents.value[indexPath.row]
            cell.contentImageView.setImage(info.media.last?.url ?? "")
            cell.titleLabel.text = info.title
            cell.sectionLabel.text = info.section
            cell.bylineLabel.text = info.byline
            cell.abstractLabel.text = info.abstract
            cell.publishedDateLabel.text = info.publishedDate?.customDateFormat("dd MMM yy") ?? ""
            return cell
        }
    }


}

extension HomePageView {
    @IBAction func filterBarButtonTap(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose Most Popular Period", message: nil , preferredStyle: .actionSheet)
        alertController.view.tintColor = .black
        
        let day = UIAlertAction(title: "Day", style: .default ) { (_) in
            self.viewModel.isSpinning.accept(true)
            self.viewModel.period.accept(.day)
            self.filterBarButton.image = MostPopularPeriod.day.filterImage
        }
        let week = UIAlertAction(title: "Week", style: .default ) { (_) in
            self.viewModel.isSpinning.accept(true)
            self.viewModel.period.accept(.week)
            self.filterBarButton.image = MostPopularPeriod.week.filterImage
        }
        let month = UIAlertAction(title: "Month", style: .default ) { (_) in
            self.viewModel.isSpinning.accept(true)
            self.viewModel.period.accept(.month)
            self.filterBarButton.image = MostPopularPeriod.month.filterImage
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: .cancel) { (_) in
            
        }
        
        alertController.addAction(day)
        alertController.addAction(week)
        alertController.addAction(month)
        alertController.addAction(cancelAction)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
            }
        }
        
        present(alertController, animated: true)
    }
    
    @IBAction func searchBarButtonTap(_ sender: Any) {
        viewModel.openSearchPage()
    }
    
    @objc private func topRefresh(_ sender: AnyObject) {
        viewModel.reloadPage()
        topRefreshControl?.endRefreshing()
    }
}
