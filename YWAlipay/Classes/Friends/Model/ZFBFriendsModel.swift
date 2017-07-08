//
//  ZFBFriendsModel.swift
//  YWAlipay
//
//  Created by Mac on 2017/6/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBFriendsModel: NSObject {
    
    var icon: String!
    var time: String!
    var title: String!
    var subTitle: String!
    
    init(dict: NSDictionary) {
        super.init()
        
        self.setValuesForKeysWithDictionary(dict as! [String:NSObject])
    }
    
}
