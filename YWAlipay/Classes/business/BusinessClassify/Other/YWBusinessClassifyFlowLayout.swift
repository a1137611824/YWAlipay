//
//  YWBusinessClassifyFlowLayout.swift
//  YWAlipay
//
//  Created by Mac on 2017/6/10.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

let numRow: CGFloat = 4
let numLine: CGFloat = 2

class YWBusinessClassifyFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        //1.设置间距
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        //2.设置sizeMake
        let itemW = self.collectionView!.bounds.size.width / numRow
        let itemH = self.collectionView!.bounds.size.height / numLine
        self.itemSize = CGSizeMake(itemW, itemH)
        
        //3.设置滚动方向为水平，是否有回弹，滚动条以及翻页
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.bounces = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.scrollDirection = .Horizontal
    }
}
