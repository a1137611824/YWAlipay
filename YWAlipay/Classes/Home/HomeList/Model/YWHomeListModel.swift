//
//  YWHomeListModel.swift
//  商家分类
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWHomeListModel: NSObject {
    var icon: String!
    var name: String!
    
    init(dict: NSDictionary) {
        super.init()
        self.setValuesForKeysWithDictionary(dict as! [String:NSObject])
    }
    
    class func loadHomeListData() -> NSArray {
        let pathFile = NSBundle.mainBundle().pathForResource("homeAllFunctions", ofType: "plist")!
        let array = NSArray(contentsOfFile: pathFile)!
        let arrayM = NSMutableArray()
        for dic in array {
            let temp = YWHomeListModel.init(dict: dic as! NSDictionary)
            arrayM.addObject(temp)
        }
        return arrayM
    }
}
