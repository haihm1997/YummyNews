//
//  SearchNewsViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 24/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SearchNewsViewController: BaseViewController {
        
    let leftButton = configure(UIButton()) {
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.setImage(UIImage(named: "arrow_back"), for: .normal)
    }
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.scopeBarBackgroundImage = nil
        searchBar.barStyle = .default
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .clear
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.className)
        tableView.rowHeight = 122
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 26, right: 0)
        return tableView
    }()
    
    let emptyView = EmptyView()
    
    let viewModel = SearchNewsViewModel()
    
    override func loadView() {
        super.loadView()
        self.view.addSubviews(leftButton, searchBar, tableView, emptyView)
        leftButton.snp.makeConstraints { maker in
            maker.width.height.equalTo(28)
            maker.leading.equalToSuperview().inset(12)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
        }
        
        searchBar.snp.makeConstraints { maker in
            maker.centerY.equalTo(leftButton.snp.centerY)
            maker.leading.equalTo(leftButton.snp.trailing).offset(6)
            maker.trailing.equalToSuperview().inset(16)
            maker.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(searchBar.snp.bottom).offset(16)
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { maker in
            maker.top.equalTo(searchBar.snp.bottom).offset(16)
            maker.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        bindViewModel()
    }
    
    private func bindViewModel() {
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
                .withLatestFrom(searchBar.rx.text.orEmpty)
                .bind(to: viewModel.inKeyword)
                .disposed(by: rx.disposeBag)
        } else {
            // Fallback on earlier versions
        }
                      
        viewModel.outNews.bind(to: tableView.rx.items(cellIdentifier: NewsCell.className, cellType: NewsCell.self)) {
            (row, element, cell) in
            cell.bind(data: element)
        }.disposed(by: rx.disposeBag)
        viewModel.outError.bind(to: ErrorHandler.defaultAlertBinder(from: self)).disposed(by: rx.disposeBag)
        viewModel.outActivity.bind(to: loadingBinder).disposed(by: rx.disposeBag)
        viewModel.outNews.bind(to: didFetchData).disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(News.self).bind(to: didSelectedNewsBinder).disposed(by: rx.disposeBag)
        leftButton.rx.tap.bind(to: didTapBack).disposed(by: rx.disposeBag)
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
            webVC.title = news.title
            target.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    var didTapBack: Binder<Void> {
        return Binder(self) { target, _ in
            target.navigationController?.popViewController(animated: true)
        }
    }
    
}

