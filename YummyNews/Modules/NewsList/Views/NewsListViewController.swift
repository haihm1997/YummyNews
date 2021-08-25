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
    
    let didSelectedNews = PublishRelay<News>()
    
    var viewModel: NewsListViewModel!
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.outNews.bind(to: tableView.rx.items(cellIdentifier: NewsCell.className, cellType: NewsCell.self)) {
            (row, element, cell) in
            cell.bind(data: element)
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(News.self).bind(to: didSelectedNews).disposed(by: rx.disposeBag)
    }
    
}

