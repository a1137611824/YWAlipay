//
//  ZFBFriendsViewController.swift
//  AlipayProject
//
//  Created by Mac on 2017/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit


class ZFBFriendsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupUI()
    }
    
    //MARK: - 界面
    private func setupUI() {
        
        tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: friendCell)
        let nib = UINib(nibName: "ZFBFriendsCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: friendCell2)
        
        
    }
    
    //MARK: - 加载数据
    private func loadData() {
        let filePath = NSBundle.mainBundle().pathForResource("Friends", ofType: "plist")!
        let array = NSArray(contentsOfFile: filePath)!
        
        let arrayM = NSMutableArray()
        for dict in array {
            let model = ZFBFriendsModel.init(dict: dict as! NSDictionary)
            arrayM.addObject(model)
        }
        friendsArray = arrayM.copy() as! NSArray
    }

    //MARK: - 懒加载
    lazy var friendsArray = {
        return NSArray()
    }()
    
    lazy var tableView = {
        return UITableView()
    }()

}


//MARK: - delegate
extension ZFBFriendsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {return 1}
        return friendsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(friendCell, forIndexPath: indexPath)
            cell.imageView?.image = UIImage(named: "APC_timeLineIcon")
            cell.textLabel?.text = "朋友圈"
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(friendCell2, forIndexPath: indexPath) as! ZFBFriendsCell
        cell.setModel(friendsArray[indexPath.row] as! ZFBFriendsModel)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let vc = YWLifeViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
            if indexPath.row == 2 {
                let sb = UIStoryboard(name: "YWFriendChat", bundle: nil)
                let chatVC = sb.instantiateViewControllerWithIdentifier("friend")
                self.navigationController?.pushViewController(chatVC, animated: false)
                
            }
            
        }
    }
    
    
    
}



