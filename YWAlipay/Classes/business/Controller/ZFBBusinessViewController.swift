//
//  ZFBBusinessViewController.swift
//  Alipay-business
//
//  Created by Mac on 2017/4/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBBusinessViewController: UITableViewController,YWBusinessClassifyViewDelegate {

    var businessData = NSArray()
    let businessStr = "business"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
    }
    
    //MARK: - 界面
    private func setupUI() {
        businessData = loadBusinessData()
        self.tableView.separatorInset = UIEdgeInsetsZero
        
        //顶部菜单视图
        let businessClassifyView = YWBusinessClassifyView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 180))
        businessClassifyView.businessClassifyData = YWBussinessClassifyModel.loadBussinessClassify()
        businessClassifyView.delegate = self
        
        
        //顶部图片视图
        let pictureView = ZFBPictureView.headerView()
        let headerViewH = pictureView.bounds.size.height/pictureView.bounds.size.width * self.tableView.bounds.size.width
        pictureView.frame = CGRectMake(0, 180, self.tableView.bounds.size.width, headerViewH - 180)
        
        let headView = UIView(frame: CGRectMake(0, 0 , SCREEN_WIDTH, CGRectGetMaxY(pictureView.frame)))
        
        headView.addSubview(businessClassifyView)
        headView.addSubview(pictureView)
   
        self.tableView.tableHeaderView = headView
        
        //MARK: - 底部视图
        let footerView = UIView(frame: CGRectMake(0, 0 , SCREEN_WIDTH, 20))
        let label = UILabel()
        label.text = "加载更多"
        label.textColor = UIColor.grayColor()
        label.font = UIFont.systemFontOfSize(15)
        footerView.addSubview(label)
        self.view.addSubview(footerView)
        self.tableView.tableFooterView = footerView
        
        label.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.top.equalTo(2)
        }
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(ZFBBusinessViewController.loadMore))
        label.userInteractionEnabled = true
        label.addGestureRecognizer(labelTap)
    }
    
    //MARK: - 点击事件
    internal func didSelectRow(row: Int) {
        //顶部菜单
        print(row)
        
    }
    
    @objc private func loadMore() {
        print("加载更多")
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return businessData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(businessStr, forIndexPath: indexPath) as? ZFBBusinessCell

        cell?.configureWithZFBBusiness(businessData[indexPath.row] as! ZFBBusiness)
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "热门推荐"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    //MARK: - 加载数据
    func loadBusinessData() -> NSArray{
        
        let dictArr = NSArray(contentsOfURL: NSBundle.mainBundle().URLForResource("business.plist", withExtension: nil)!)
        let mutableArr = NSMutableArray(capacity: (dictArr?.count)!)
        for dict in dictArr! {
            mutableArr.addObject(ZFBBusiness(dict: dict as! [String : AnyObject]))
        }
        return mutableArr.copy() as! NSArray
    }
    


}
