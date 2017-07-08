//
//  ZFBBusinessCell.swift
//  Alipay-business
//
//  Created by Mac on 2017/4/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBBusinessCell: UITableViewCell {

    
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var averagePriceLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var offNumLabel: UILabel!
    @IBOutlet var subtractLabel: UILabel!
    @IBOutlet var discountLabel: UILabel!
    @IBOutlet var levelView: UIView!
    
    

    func configureWithZFBBusiness(business: ZFBBusiness) {
        self.iconView.image = UIImage(named: business.icon)
        self.nameLabel.text = business.name
        self.levelLabel.text = business.level.description
        self.averagePriceLabel.text = NSString(format: "人均消费%@元", "\(business.averagePrice)") as String
        self.distanceLabel.text = NSString(format: "距离%@m", "\(business.distance)") as String
        self.offNumLabel.text = NSString(format: "%@折", "\(business.offNum)") as String
        self.discountLabel.text = business.discount
        
        ZFBLevelView.showInView(levelView, value: business.level)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subtractLabel.backgroundColor = UIColor(red: 1, green: 147/255.0, blue: 93/255.0, alpha: 1)
    }


    
}
