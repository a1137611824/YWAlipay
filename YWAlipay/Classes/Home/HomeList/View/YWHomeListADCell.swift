//
//  YWHomeListADCell.swift
//  商家分类
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWHomeListADCell: UICollectionViewCell {

    @IBOutlet var cycleView: ZFBCycleView!

    
    func setImageNames(imageNames: NSArray) {
        cycleView.imageNames = imageNames as [AnyObject]
    }

}
