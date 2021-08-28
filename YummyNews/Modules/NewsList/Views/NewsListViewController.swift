//
//  NewListViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class NewListViewController: BaseViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.className)
        tableView.rowHeight = 122
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 26, right: 0)
        return tableView
    }()
    
    var openRegisterPremiun: (() -> Void)?
    
    let didSelectedNews = PublishRelay<News>()
    
    var forceReload: Bool = false
    
    var viewModel: NewsListViewModel!
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bindViewModel()
        
        tableView.es.addInfiniteScrolling { [weak self] in
            guard let self = self else { return }
            if self.viewModel.outNews.value.count >= 360 {
                self.tableView.es.noticeNoMoreData()
            } else {
                let currentOffset = self.viewModel.inLoadMore.value ?? 0
                self.viewModel.inLoadMore.accept(currentOffset + 1)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if forceReload {
            viewModel.inLoadMore.accept(0)
        } else {
            if viewModel.inLoadMore.value == nil {
                viewModel.inLoadMore.accept(0)
            }
        }
    }
    
    private func bindViewModel() {
        viewModel.outNews.bind(to: tableView.rx.items(cellIdentifier: NewsCell.className, cellType: NewsCell.self)) {
            (row, element, cell) in
            cell.bind(data: element)
        }.disposed(by: rx.disposeBag)
        viewModel.outNews.bind(to: didFetchNewsBinder).disposed(by: rx.disposeBag)
        viewModel.outActivity.bind(to: loadingBinder).disposed(by: rx.disposeBag)
        viewModel.outError.bind(to: ErrorHandler.defaultAlertBinder(from: self)).disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(News.self).bind(to: didSelectedNews).disposed(by: rx.disposeBag)
    }
    
    var didFetchNewsBinder: Binder<[News]> {
        return Binder(self) { target, _ in
            target.forceReload = false
            if !target.viewModel.couldLoadMore {
                ErrorHandler.showDefaultAlert(message: "Please register Premium Plan to read more news",
                                              from: target) {
                    target.openRegisterPremiun?()
                }
            }
            target.tableView.es.stopLoadingMore()
        }
    }
}

