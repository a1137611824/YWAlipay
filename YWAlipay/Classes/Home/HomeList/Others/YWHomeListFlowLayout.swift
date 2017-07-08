//
//  YWHomeListFlowLayout.swift
//  商家分类
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWHomeListFlowLayout: UICollectionViewFlowLayout {
    
    
    override func prepareLayout() {
        super.prepareLayout()
        
        //1.设置间距
        self.minimumLineSpacing = 1
        self.minimumInteritemSpacing = 1
        
        //2.设置sizeMake
        //3.设置基本属性
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.bounces = true
    }
}
