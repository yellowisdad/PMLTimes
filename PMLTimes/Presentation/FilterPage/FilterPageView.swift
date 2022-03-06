//
//  FilterPageView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import UIKit
import RxSwift

class FilterPageView: BaseViewController, UIScrollViewDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var disposeBag = DisposeBag()
    private var viewModel: FilterPageViewModel!
    
    static func create(with viewModel: FilterPageViewModel) -> UIViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterPageView") as? FilterPageView else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(Self.description())")
        }
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.top = 10
        
        tableView.register(UINib(nibName: "DatePickerTableViewCell",
                                 bundle: nil),
                                 forCellReuseIdentifier: "beginDatePickerCell")
        
        tableView.register(UINib(nibName: "DatePickerTableViewCell",
                                 bundle: nil),
                                 forCellReuseIdentifier: "endDatePickerCell")
        
        tableView.register(UINib(nibName: "SortSearchTableViewCell",
                                 bundle: nil),
                                 forCellReuseIdentifier: "sortCell")
    }
}

extension FilterPageView {
    
    @IBAction func backButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func useButtonTap(_ sender: Any) {
        viewModel.sendFilter()
        dismiss(animated: true, completion: nil)
    }
}

extension FilterPageView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath) as? SortSearchTableViewCell else { return UITableViewCell() }
            
            cell.titleLabel.text = "Sort"
            cell.newestRadioBoxView.titleLabel.text = SearchSort.newest.rawValue
            cell.oldestRadioBoxView.titleLabel.text = SearchSort.oldest.rawValue
            cell.relevanceRadioBoxView.titleLabel.text = SearchSort.relevance.rawValue
            cell.check(viewModel.sort)
            
            cell.newestRadioBoxView.callCheck
                .subscribe(onNext: { isCheck in
                    cell.check(.newest)
                    self.viewModel.sort = .newest
                })
                .disposed(by: disposeBag)
            
            cell.oldestRadioBoxView.callCheck
                .subscribe(onNext: { isCheck in
                    cell.check(.oldest)
                    self.viewModel.sort = .oldest
                })
                .disposed(by: disposeBag)
            
            cell.relevanceRadioBoxView.callCheck
                .subscribe(onNext: { isCheck in
                    cell.check(.relevance)
                    self.viewModel.sort = .relevance
                })
                .disposed(by: disposeBag)
            
            return cell
            
        } else {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "beginDatePickerCell", for: indexPath) as? DatePickerTableViewCell else { return UITableViewCell() }
                
                cell.titleLabel.text = "Begin Date"
                cell.setDate(date: viewModel.beginDate)
                cell.callDateChanged
                    .subscribe(onNext: { date in
                        self.viewModel.beginDate = date
                    })
                    .disposed(by: disposeBag)
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "endDatePickerCell", for: indexPath) as? DatePickerTableViewCell else { return UITableViewCell() }
                
                cell.titleLabel.text = "End Date"
                cell.setDate(date: viewModel.endDate)
                cell.callDateChanged
                    .subscribe(onNext: { date in
                        self.viewModel.endDate = date
                    })
                    .disposed(by: disposeBag)
                return cell
                
            }
        }
    }
}
