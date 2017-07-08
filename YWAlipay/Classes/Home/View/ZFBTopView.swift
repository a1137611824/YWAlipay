//
//  ZFBTopView.swift
//  AlipayProject
//
//  Created by Mac on 2017/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBTopView: UIView {

    var scanBtn = UIButton(type: UIButtonType.System)
    var payBtn = UIButton(type: UIButtonType.System)
    var cardBtn = UIButton(type: UIButtonType.System)
    var xiuxiuBtn = UIButton(type: UIButtonType.System)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topViewInit()
    }
    
    //MARK：-topView的实现
    func topViewInit() {
        scanBtn = topViewTitleWithImageDetail("home_scan", labelTitle: "扫一扫")
        payBtn = topViewTitleWithImageDetail("home_pay", labelTitle: "支付")
        cardBtn = topViewTitleWithImageDetail("home_card", labelTitle: "卡券")
        xiuxiuBtn = topViewTitleWithImageDetail("home_xiu", labelTitle: "咻一咻")
        
        
        
        
        scanBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.bottom.equalTo(0)
        }
        
        payBtn.snp_makeConstraints { (make) in
            make.left.equalTo(scanBtn.snp_right).offset(0)
            make.width.equalTo(scanBtn.snp_width).offset(0)
            make.top.bottom.equalTo(0)
        }
        
        cardBtn.snp_makeConstraints { (make) in
            make.left.equalTo(payBtn.snp_right).offset(0)
            make.width.equalTo(payBtn.snp_width).offset(0)
            make.top.bottom.equalTo(0)
        }
        
        xiuxiuBtn.snp_makeConstraints { (make) in
            make.left.equalTo(cardBtn.snp_right).offset(0)
            make.width.equalTo(cardBtn.snp_width).offset(0)
            make.right.equalTo(0)
            make.top.bottom.equalTo(0)
        }
        
        
    }
    
    
    
    //topViewtitleWithImageInit
    func topViewTitleWithImageDetail(imageName: String, labelTitle: String) -> UIButton{
        let btn = UIButton(type: UIButtonType.System)
        let attrStr = NSAttributedString.imageTextInit(UIImage(named: imageName)!, imageWH: 35, labelTitle: labelTitle, fontSize: 15, titleColor: UIColor.whiteColor(), labelSpacing: 8)
        
        btn.titleLabel?.textAlignment = NSTextAlignment.Center
        btn.titleLabel?.numberOfLines = 0
        btn.setAttributedTitle(attrStr, forState: UIControlState.Normal)
        self.addSubview(btn)
        
        return btn
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
