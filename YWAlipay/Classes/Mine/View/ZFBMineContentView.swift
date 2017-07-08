//
//  ZFBMineContentView.swift
//  YWAlipay
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBMineContentView: UICollectionViewCell {

    @IBOutlet var forImage: UIImageView!
    @IBOutlet var forTitle: UILabel!
    @IBOutlet var forContent: UILabel!
    
    func setModel(model: ZFBMineOptionModel) {
        forImage.image = UIImage(named: model.icon!)
        forTitle.text = model.name
        forContent.text = model.message
        
        if model.message == "立即转入" {
            forContent.textColor = UIColor.blueColor()
        }else{
            forContent.textColor = UIColor.grayColor()
        }
    }

}
