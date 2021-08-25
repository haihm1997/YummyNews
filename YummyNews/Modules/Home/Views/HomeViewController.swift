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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var pageMenuContainer: UIView!
    var pageMenu: CAPSPageMenu!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        pageMenu = CAPSPageMenu(viewControllers: getControllers(),
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
    
    private func getControllers() -> [UIViewController] {
        var controllers: [UIViewController] = []
        for item in Category.allCases {
            let vc = NewListViewController()
            vc.viewModel = NewsListViewModel()
            vc.title = item.title
            vc.didSelectedNews.bind(to: didSelectedNewsBinder).disposed(by: vc.rx.disposeBag)
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
                ()
            case .favorite:
                self?.openSelectCategories()
            case .bookmarked:
                ()
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
        navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
    var didSelectedNewsBinder: Binder<News> {
        return Binder(self) { target, news in
            let webVC = NavYummyWebView()
            webVC.url = news.url
            webVC.title = news.category
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
