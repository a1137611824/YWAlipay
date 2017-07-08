//
//  YWFriendChatCell.swift
//  微信聊天
//
//  Created by Mac on 2017/6/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWFriendChatCell: UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var contentText: UILabel!
    
    
    //MARK: - 加载数据
    func setModel(model: YWFriendChatModel) {
        timeLabel.text = model.time
        contentText.text = model.text
    }



}
