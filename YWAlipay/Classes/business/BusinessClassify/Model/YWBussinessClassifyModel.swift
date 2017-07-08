//
//  YWBussinessClassifyModel.swift
//  YWAlipay
//
//  Created by Mac on 2017/6/10.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWBussinessClassifyModel: NSObject {
    var icon: String!
    var name: String!
    
    init(dict: NSDictionary) {
        super.init()
        
        self.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
    }
    
    class func loadBussinessClassify() -> NSArray {
        let filePath = NSBundle.mainBundle().pathForResource("YWBussinessClassify", ofType: "plist")!
        let businessArray = NSArray(contentsOfFile: filePath)!
        
        let mulArray  = NSMutableArray(capacity: businessArray.count)
        businessArray.enumerateObjectsUsingBlock { (obj, idx, stop) in
            mulArray.addObject(YWBussinessClassifyModel(dict: obj as! NSDictionary))
        }
        
        return mulArray.copy() as! NSArray
    }
   
    
}
