//
//  FilterTagsListView.swift
//  VNShop
//
//  Created by Tung Nguyen on 10/24/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import UIKit

class FilterTagsListView: UIView {
    
    var labels: [String] = []
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 48, height: 32)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.backgroundColor = .uiBg
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerCellNib(FilterTagCell.self)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        addSubviews()
    }
    
    func addSubviews() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func reload(with labels: [String]) {
        self.labels = labels
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }

}

extension FilterTagsListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FilterTagCell.self, idxPath: indexPath)!
        cell.setup(with: labels[safe: indexPath.item])
        cell.tag = indexPath.item
        return cell
    }
      
}
