//
//  YWLifeModel.swift
//  支付宝生活界面
//
//  Created by Mac on 2017/6/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWLifeModel: NSObject {
    var icon: String!
    var name: String!
    var content: String!
    var time: String!
    var picture: String!
    var isMine: NSNumber!
    
    init(dict: NSDictionary) {
        super.init()
        self.setValuesForKeysWithDictionary(dict as! [String:NSObject])
    }
    
}
