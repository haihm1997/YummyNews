//
//  BookmarksViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 26/08/2021.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

class BookmarksViewController: BaseViewController {
        
    let navigationView = configure(MyNavigationView()) {
        $0.title = "Bookmarks"
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.className)
        tableView.rowHeight = 122
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 26, right: 0)
        return tableView
    }()
     
    let emptyView = configure(EmptyView()) {
        $0.content = "You have not bookmarked news yet!"
        $0.image = UIImage(named: "ic_bookmark_empty")
    }
    
    let viewModel = BookmarksViewModel()
        
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.height.equalTo(Constant.NavigationSize.totalHeight)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(navigationView.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view.addSubview(emptyView)
        emptyView.snp.makeConstraints { maker in
            maker.top.equalTo(navigationView.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
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
        viewModel.outNews.bind(to: didFetchData).disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(News.self).bind(to: didSelectedNewsBinder).disposed(by: rx.disposeBag)
        navigationView.leftAction.bind(to: didTapBack).disposed(by: rx.disposeBag)
    }
    
    var didFetchData: Binder<[News]> {
        return Binder(self) { target, result in
            target.tableView.isHidden = result.isEmpty
            target.emptyView.isHidden = !result.isEmpty
        }
    }
    
    var didSelectedNewsBinder: Binder<News> {
        return Binder(self) { target, news in
            let webVC = NavYummyWebView()
            webVC.url = news.url
            webVC.title = news.category
            target.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    var didTapBack: Binder<Void> {
        return Binder(self) { target, _ in
            target.navigationController?.popViewController(animated: true)
        }
    }
    
}

