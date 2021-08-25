//
//  NewsCell.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import UIKit
import SnapKit

class NewsCell: BaseTableViewCell {
    
    let newsPresentationImage = configure(UIImageView()) {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleToFill
    }
    
    let titleLabel = configure(UILabel()) {
        $0.font = Fonts.medium(size: 15)
        $0.textColor = .textPrimary
        $0.numberOfLines = 2
    }
    
    let subTitleLabel = configure(UILabel()) {
        $0.font = Fonts.regular(size: 13)
        $0.textColor = .textSecondary
        $0.numberOfLines = 2
    }
    
    let dateLabel = configure(UILabel()) {
        $0.font = Fonts.regular(size: 12)
        $0.textColor = .textSecondary
    }
    
    override func commonInit() {
        super.commonInit()
        selectionStyle = .none
        contentView.addSubviews(newsPresentationImage, titleLabel, subTitleLabel, dateLabel)
        
        newsPresentationImage.snp.makeConstraints { maker in
            maker.leading.top.bottom.equalToSuperview().inset(16)
            maker.height.equalTo(90)
            maker.width.equalTo(130)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(newsPresentationImage.snp.top)
            maker.leading.equalTo(newsPresentationImage.snp.trailing).offset(16)
            maker.trailing.equalToSuperview().inset(16)
        }
        
        subTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.leading)
            maker.top.equalTo(titleLabel.snp.bottom).offset(4)
            maker.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.leading)
            maker.bottom.equalTo(newsPresentationImage.snp.bottom)
        }
    }
    
    func bind(data: News) {
        newsPresentationImage.setImageByKF(imageURL: data.image)
        titleLabel.text = data.title
        subTitleLabel.text = data.description
        dateLabel.text = data.publishAt
    }
    
}
