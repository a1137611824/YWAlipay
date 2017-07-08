//
//  ZFBBusiness.swift
//  Alipay-business
//
//  Created by Mac on 2017/4/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBBusiness: NSObject {

    let Keyicon = "icon"
    let Keyname = "name"
    let Keydiscount = "discount"
    let KeyaveragePrice = "averagePrice"
    let Keydistance = "distance"
    let KeyoffNum = "offNum"
    let Keylevel = "level"
    
    /**配图**/
    var icon = ""
    /**店名**/
    var name = ""
    /**优惠信息**/
    var discount = ""
    /**人均消费**/
    var averagePrice = 0
    /**距离**/
    var distance = 0
    /**打折**/
    var offNum = 0.0
    /**评价**/
    var level = 0.0
    
    init(dict: [String: AnyObject]) {
        icon = dict[Keyicon] as? String ?? ""
        name = dict[Keyname] as? String ?? ""
        discount = dict[Keydiscount] as? String ?? ""
        averagePrice = dict[KeyaveragePrice] as? Int ?? 0
        distance = dict[Keydistance] as? Int ?? 0
        offNum = dict[KeyoffNum] as? Double ?? 0
        level = dict[Keylevel] as? Double ?? 0
        
    }
    
}
