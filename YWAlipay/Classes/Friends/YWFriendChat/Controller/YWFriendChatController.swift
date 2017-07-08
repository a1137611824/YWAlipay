//
//  YWFriendChatController.swift
//  微信聊天
//
//  Created by Mac on 2017/6/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWFriendChatController: UIViewController , UITextFieldDelegate{

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var barBottomContraint: NSLayoutConstraint!
    
    var autoReplyData: NSDictionary!
    var nomTime: String = ""
    
    override func viewDidLayoutSubviews() {
        let indexPath = NSIndexPath(forRow: (chatData as NSArray).count - 1, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //MARK: - 界面
    private func setupUI() {
    
        self.title = "超哥"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let filePath = NSBundle.mainBundle().pathForResource("AutoReply", ofType: "plist")!
        autoReplyData = NSDictionary(contentsOfFile: filePath)
        
        chatData = loadPlistChats()
    
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsHorizontalScrollIndicator = false
        
        //监听键盘的frame的改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YWFriendChatController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - 聊天的具体实现
    //自动回复
    // 根据用户发送消息自动回复
    func autoReply(text: NSString) -> String {
        for i in 0..<text.lengthOfBytesUsingEncoding(NSUnicodeStringEncoding)/2 {
      
            let word = text.substringWithRange(NSMakeRange(i, 1))
            if autoReplyData.valueForKey(word) != nil {
                return autoReplyData.valueForKey(word) as! String
            }
        }
        return "你说什么，我没有听清楚"
    }
    
    /**
     * 发消息
     */
    func sendMessageWithText(text: String, type: Int) {
        let chat: YWFriendChatModel = YWFriendChatModel(dict: NSDictionary(dictionary: [:]))
        chat.time = "20:00"
        chat.text = text
        chat.type = NSNumber(integer: type)
        if chat.time == nomTime {
            chat.time = ""
        }else{
            nomTime = chat.time
        }
        chatData.addObject(chat)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendMessageWithText(textField.text!, type: 1)
        sendMessageWithText(autoReply(textField.text!), type: 0)
        
        tableView.reloadData()
        textField.text = nil
        return true
    }
    
    func keyboardWillChangeFrame(note: NSNotification) {
        //获取键盘信息
        let dict = note.userInfo!
        //取出模型变化的frame
        let keyboardFrame = dict[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        let moveValue = self.view.bounds.size.height - keyboardFrame.origin.y + 68
        
        //更改约束
        self.barBottomContraint.constant = moveValue
        UIView.animateWithDuration(0.25) {
            self.view.layoutIfNeeded()
        }
    }

    
    

    
    //MARK: – 加载plist文件
    //加载聊天数据
    func loadPlistChats() -> NSMutableArray {
        let filePath = NSBundle.mainBundle().pathForResource("Chats", ofType: "plist")!
        let array = NSArray(contentsOfFile: filePath)!
        
        let arrayM = NSMutableArray()
        for dic in array {
            let chat = YWFriendChatModel(dict: dic as! NSDictionary)
            
            if chat.time == nomTime {
                chat.time = ""
            }else{
                self.nomTime = chat.time
            }
            arrayM.addObject(chat)
        }
        return arrayM
    }
    
    //MARK: - 懒加载
    lazy var chatData = {
        return NSMutableArray()
    }()

}

//MARK: - delegate 
extension YWFriendChatController: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chat = chatData[indexPath.row] as! YWFriendChatModel
        let cell = tableView.dequeueReusableCellWithIdentifier(chat.type == 1 ? "me" : "other", forIndexPath: indexPath) as! YWFriendChatCell
        cell.setModel(chat)
        
        return cell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
        return tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}












