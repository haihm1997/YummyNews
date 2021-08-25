//
//  NavYummyWebView.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 24/08/2021.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

class NavYummyWebView: BaseViewController {
    
    let webView = WKWebView()
    
    let closeButton = configure(UIButton()) {
        $0.setImage(UIImage(named: "ic_close"), for: .normal)
    }
    
    let navigationView = configure(MyNavigationView()) {
        $0.title = "Movie Detail"
    }
    
    var url: String!
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.height.equalTo(Constant.NavigationSize.totalHeight)
        }
        
        self.view.addSubview(webView)
        webView.snp.makeConstraints { maker in
            maker.top.equalTo(navigationView.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        bindState()
        
        if let pageUrl = URL(string: url) {
            let requestUrl = URLRequest(url: pageUrl)
            webView.load(requestUrl)
        }
        
        navigationView.title = self.title
        navigationView.leftAction.bind(to: closeBinder).disposed(by: rx.disposeBag)
    }
    
    func bindState() {
        let loading = webView.rx.loading.share(replay: 1)
        
        Observable
            .zip(loading, loading.skip(1)) { !$0 && $1 }
            .filter { $0 }
            .map { _ in true }
            .bind(to: loadingBinder)
            .disposed(by: rx.disposeBag)
        
        Observable
            .zip(loading, loading.skip(1)) { $0 && !$1 }
            .filter { $0 }
            .map { _ in false }
            .bind(to: loadingBinder)
            .disposed(by: rx.disposeBag)
        
    }
    
    var closeBinder: Binder<Void> {
        return Binder(self) { target, _ in
            target.navigationController?.popViewController(animated: true)
        }
    }
    
}

