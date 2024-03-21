//
//  MMBaseCollectionView.swift
//  MiddleMall
//
//  Created by 无名 on 2019/11/7.
//  Copyright © 2019 无名. All rights reserved.
//

import UIKit

class MMBaseCollectionView: UICollectionView,
                            UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout {
    var clickCellBlocl: OneParameterBlock!//点击cell进入详情页
    
    var objectListModels: [AnyObject]? {
        didSet {
            self.reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        UICollectionViewFlowLayout().scrollDirection = .horizontal
        objectListModels = []
        self.delegate = self
        self.dataSource = self
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectListModels!.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if self.clickCellBlocl != nil && indexPath.row < self.objectListModels!.count {
            self.clickCellBlocl(self.objectListModels![indexPath.row])
        }
    }
}
