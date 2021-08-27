//
//  YummyWebView.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 24/08/2021.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

class YummyWebView: BaseViewController {
    
    let webView = WKWebView()
    
    let closeButton = configure(UIButton()) {
        $0.setImage(UIImage(named: "ic_close"), for: .normal)
    }
    
    var url: String!
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        webView.snp.makeConstraints { maker in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(16)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            maker.width.height.equalTo(36)
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
        
        closeButton.rx.tap.bind(to: dismisBinder).disposed(by: rx.disposeBag)
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
    
    var dismisBinder: Binder<Void> {
        return Binder(self) { target, _ in
            target.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension Reactive where Base: WKWebView {

    var loading: Observable<Bool> {
        return observeWeakly(Bool.self, "loading", options: [.initial, .new]) .map { $0 ?? false }
    }

}
