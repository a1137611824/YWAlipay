//
//  YWLifeHeaderVeiw.swift
//  支付宝生活界面
//
//  Created by Mac on 2017/6/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWLifeHeaderVeiw: UIView {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 界面
    private func setupUI() {
        
        let headLabel = UILabel()
        headLabel.text = "朋友圈"
        headLabel.textColor = UIColor.redColor()
        headLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(headLabel)
        
        let contentImage = UIImageView()
        contentImage.image = UIImage(named: "default_nearby_scene")
        self.addSubview(contentImage)
        
        let stateLabel = UILabel()
        stateLabel.text = "动态"
        stateLabel.textColor = UIColor.blueColor()
        stateLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(stateLabel)
        
        let baseLine = UILabel()
        baseLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(baseLine)
        
        headLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(8)
            make.height.equalTo(14)
        }
        contentImage.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(headLabel.snp_bottom).offset(8)
            make.right.equalTo(-8)
            make.height.equalTo(100)
        }
        
        baseLine.snp_makeConstraints { (make) in
            make.top.equalTo(contentImage.snp_bottom).offset(8)
            make.left.right.equalTo(0)
            make.height.equalTo(1)
        }
        
        stateLabel.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(baseLine.snp_bottom).offset(8)
            make.height.equalTo(14)
        }
    }

}









