//
//  YWFriendChatModel.swift
//  微信聊天
//
//  Created by Mac on 2017/6/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWFriendChatModel: NSObject {
    var time: String!
    var text: String!
    var type: NSNumber!
    
//    enum YWFriendChatType: Int {
//        case Other
//        case Me
//    }

    init(dict: NSDictionary) {
        super.init()
        super.setValuesForKeysWithDictionary(dict as! [String:NSObject])
    }
    
    
    
    
}
