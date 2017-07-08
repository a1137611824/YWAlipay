//
//  YWHomeListCell.swift
//  商家分类
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWHomeListCell: UICollectionViewCell {

    
    @IBOutlet var forIcon: UIImageView!
    @IBOutlet var forLabel: UILabel!
    
    func setModel(model: YWHomeListModel) {
        forIcon.image = UIImage(named:model.icon!)
        forLabel.text = model.name
    }

}
