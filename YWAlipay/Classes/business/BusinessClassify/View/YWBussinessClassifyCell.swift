//
//  YWBussinessClassifyCell.swift
//  YWAlipay
//
//  Created by Mac on 2017/6/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWBussinessClassifyCell: UICollectionViewCell {
    var iconView: UIImageView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 界面
    private func setupUI() {
        let iconImage = UIImageView()
        let textLabel = UILabel()
        textLabel.textColor = UIColor.darkGrayColor()
        textLabel.font = UIFont.systemFontOfSize(15)
        self.contentView.addSubview(iconImage)
        self.contentView.addSubview(textLabel)
        
        iconImage.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.top.equalTo(8)
            make.width.height.equalTo(35)
        }
        
        textLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.top.equalTo(iconImage.snp_bottom).offset(8)
        }
        
        self.iconView = iconImage
        self.nameLabel = textLabel
        
    }
    
    //MARK: - data
    func setBussinessClassify(businessClassify: YWBussinessClassifyModel) {
        self.iconView.image = UIImage(named: businessClassify.icon!)
        self.nameLabel.text = businessClassify.name
    }
    
}
