//
//  BaseTableViewCell.swift
//  OrderUI
//
//  Created by Hoang Hai on 13/05/2021.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
    }
    
}
