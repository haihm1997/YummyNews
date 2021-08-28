//
//  HomeViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import UIKit
import SnapKit
import SideMenu
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var pageMenuContainer: UIView!
    var pageMenu: CAPSPageMenu!
    
    let viewModel = HomeViewModel()
    
    lazy var pageControllers: [NewListViewController] = {
        return getControllers()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupPageView()
    }
    
    private func setupPageView() {
        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(40),
            .selectionIndicatorColor(.black),
            .selectedMenuItemLabelColor(.black),
            .unselectedMenuItemLabelColor(.uiNeutral),
            .scrollMenuBackgroundColor(.white),
            .menuItemSeparatorColor(.clear),
            .useMenuLikeSegmentedControl(false),
            .menuItemFont(Fonts.regular(size: 14)),
            .scrollAnimationDurationOnMenuItemTap(700),
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: pageControllers,
                                frame: CGRect(x: 0, y: 0,
                                              width: Constant.Size.screenWidth,
                                              height: Constant.Size.screenHeight - 60 - Constant.SafeArea.topPadding),
                                pageMenuOptions: parameters)
        self.addChild(pageMenu)
        let pageMenuView = pageMenu.view!
        pageMenuContainer.addSubview(pageMenuView)
        pageMenuView.snp.makeConstraints { maker in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
        pageMenu.didMove(toParent: self)
    }
    
    private func getControllers() -> [NewListViewController] {
        var controllers: [NewListViewController] = []
        for item in Category.allCases {
            let vc = NewListViewController()
            vc.viewModel = NewsListViewModel(languages: viewModel.selectedLanguages,
                                             categories: [item])
            vc.title = item.title
            vc.didSelectedNews.bind(to: didSelectedNewsBinder).disposed(by: vc.rx.disposeBag)
            vc.openRegisterPremiun = { [weak self] in
                let premiumVC = PremiumViewController.instantiateFromNib()
                self?.present(premiumVC, animated: true, completion: nil)
            }
            controllers.append(vc)
        }
        return controllers
    }
    
    @IBAction func didTapMenu(_ sender: Any) {
        let sideMenuVC = YummyMenuViewController.instantiateFromNib()
        let menu = SideMenuNavigationController(rootViewController: sideMenuVC)
        menu.setNavigationBarHidden(true, animated: false)
        menu.presentationStyle = .menuSlideIn
        menu.presentationStyle.menuStartAlpha = 0.3
        menu.presentationStyle.onTopShadowOpacity = 0.5
        menu.enableTapToDismissGesture = true
        menu.enableTapToDismissGesture = true
        menu.leftSide = true
        menu.menuWidth = 280
        sideMenuVC.didSelectedMenu = { [weak self] menu in
            switch menu {
            case .premium:
                let premiumVC = PremiumViewController.instantiateFromNib()
                self?.present(premiumVC, animated: true, completion: nil)
            case .favorite:
                self?.openSelectCategories()
            case .bookmarked:
                let bookmarkVC = BookmarksViewController()
                self?.navigationController?.pushViewController(bookmarkVC, animated: true)
            case .termOfUse(let url):
                self?.openWeb(with: url, title: "Term of use")
            case .privaryPolicy(let url):
                self?.openWeb(with: url, title: "Privacy Policy")
            }
            
        }
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        let searchVC = SearchNewsViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

extension HomeViewController {
    
    private func openSelectCategories() {
        let categoriesVC = SelectLanguageController.instantiateFromNib()
        categoriesVC.didSelectedLanguages = { [weak self] languages in
            self?.viewModel.setSelectedLanguages(selectedLanguages: languages)
            self?.forceReloadPages()
        }
        navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
    func forceReloadPages() {
        for i in 0..<pageControllers.count {
            if i == pageMenu.currentPageIndex {
                if let currentPage = pageControllers[safe: i] {
                    currentPage.viewModel.setLanguages(languages: viewModel.selectedLanguages)
                    currentPage.viewModel.inLoadMore.accept(0)
                }
            } else {
                let page = pageControllers[safe: i]
                page?.viewModel.setLanguages(languages: viewModel.selectedLanguages)
                page?.forceReload = true
            }
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
    
    private func openWeb(with link: String, title: String) {
        let webVC = NavYummyWebView()
        webVC.url = link
        webVC.title = title
        navigationController?.pushViewController(webVC, animated: true)
    }
    
}
