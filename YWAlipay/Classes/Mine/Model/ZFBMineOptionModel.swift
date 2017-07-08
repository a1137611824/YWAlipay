//
//  ZFBMineOptionModel.swift
//  YWAlipay
//
//  Created by Mac on 2017/7/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBMineOptionModel: NSObject {

    var message: String?
    var name: String?
    var icon: String?
    
    init(dict: NSDictionary) {
        super.init()
        self.setValuesForKeysWithDictionary(dict as! [String:NSObject])
    }
    
    class func loadMineModel() -> NSArray {
        let pathFile = NSBundle.mainBundle().pathForResource("MineOption", ofType: "plist")!
        let array = NSArray(contentsOfFile: pathFile)!
        
        let arrayM = NSMutableArray()
        for dic in array {
            //将字典转换为模型
            let temp = ZFBMineOptionModel(dict: dic as! NSDictionary)
            arrayM.addObject(temp)
        }
        return arrayM
        
    }
    
}
