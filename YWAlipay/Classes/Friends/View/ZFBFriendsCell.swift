//
//  ZFBFriendsCell.swift
//  YWAlipay
//
//  Created by Mac on 2017/6/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBFriendsCell: UITableViewCell {

    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    func setModel(model: ZFBFriendsModel) {
        iconImage.image = UIImage(named: model.icon)
        captionLabel.text = model.title
        detailLabel.text = model.subTitle
        timeLabel.text = model.time
    }
    
    

   
    
}
