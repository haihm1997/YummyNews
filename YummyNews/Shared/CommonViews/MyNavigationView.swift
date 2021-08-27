//
//  MyNavigationView.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 07/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxSwift

class MyNavigationView: BaseCustomView {
    
    let leftButtonImage = configure(UIImageView()) {
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "arrow_back")
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = configure(UILabel()) {
        $0.font = Fonts.medium(size: 18)
        $0.textColor = .darkGray
        $0.textAlignment = .center
    }
    
    let leftButton = configure(UIButton()) {
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    let rightButtonImage = configure(UIImageView()) {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
    }
    
    let rightButton = configure(UIButton()) {
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    let headerView = configure(UIView()) {
        $0.backgroundColor = .white
    }
    
    let navigationContainer = configure(UIView()) {
        $0.backgroundColor = .white
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var leftButtonIcon: UIImage? {
        didSet {
            leftButtonImage.image = leftButtonIcon
        }
    }
    
    var rightButtonIcon: UIImage? {
        didSet {
            rightButtonImage.image = rightButtonIcon
        }
    }
    
    var rightAction: Observable<Void> {
        return rightButton.rx.tap.asObservable()
    }
    
    var leftAction: Observable<Void> {
        return leftButton.rx.tap.asObservable()
    }
    
    override func commonInit() {
        self.backgroundColor = .clear
        headerView.addSubviews(titleLabel, leftButtonImage, leftButton, rightButtonImage, rightButton)
        leftButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(36)
            maker.width.equalTo(100)
            maker.centerY.equalToSuperview()
        }
        
        leftButtonImage.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(28)
            maker.leading.equalToSuperview().inset(12)
            maker.centerY.equalToSuperview()
        }
        
        rightButtonImage.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(28)
            maker.trailing.equalToSuperview().inset(16)
            maker.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(36)
            maker.trailing.equalToSuperview().inset(12)
            maker.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalToSuperview()
            maker.leading.equalToSuperview().inset(60)
        }
        
        navigationContainer.addSubview(headerView)
        headerView.snp.makeConstraints { (maker) in
            maker.bottom.leading.trailing.equalToSuperview()
            maker.height.equalTo(Constant.NavigationSize.header)
        }
        
        addSubview(navigationContainer)
        navigationContainer.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.snp.bottom).inset(Constant.NavigationSize.shadowPathHeight)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        navigationContainer.layer.shadowColor = UIColor.black.cgColor
        navigationContainer.layer.shadowPath = UIBezierPath(rect: navigationContainer.frame).cgPath
        navigationContainer.layer.shadowRadius = 5
        navigationContainer.layer.shadowOffset = CGSize(width: 0, height: Constant.NavigationSize.shadowPathHeight)
        navigationContainer.layer.shadowOpacity = 0.08
    }
    
}
