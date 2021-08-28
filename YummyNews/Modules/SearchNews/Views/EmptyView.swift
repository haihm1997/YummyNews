//
//  EmptyView.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 28/08/2021.
//

import UIKit
 
class EmptyView: BaseCustomView {
    
    let emptyImage = configure(UIImageView()) {
        $0.image = UIImage(named: "ic_search_empty")
        $0.backgroundColor = .clear
    }
    
    let contentLabel = configure(UILabel()) {
        $0.text = "We can not find your news"
        $0.font = Fonts.medium(size: 15)
        $0.textColor = .textSecondary
        $0.textAlignment = .center
    }
    
    var image: UIImage? = UIImage(named: "ic_search_empty") {
        didSet {
            emptyImage.image = image
        }
    }
    
    var content: String = "" {
        didSet {
            contentLabel.text = content
        }
    }
    
    override func commonInit() {
        super.commonInit()
        
        self.addSubviews(emptyImage, contentLabel)
        emptyImage.snp.makeConstraints { maker in
            maker.width.height.equalTo(120)
            maker.top.equalToSuperview().inset(56)
            maker.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(emptyImage.snp.bottom).offset(16)
            maker.leading.equalToSuperview().inset(24)
        }
    }
    
}
