//
//  FilterTagCell.swift
//  VNShop
//
//  Created by Tung Nguyen on 10/24/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import UIKit

class FilterTagCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    var isHeightCalculated: Bool = false
        
    override func awakeFromNib() {
        super.awakeFromNib()
        containerViewHeightConstraint.constant = 32
    }
    
    
    func setup(with label: String?) {
        nameLabel.text = label
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
