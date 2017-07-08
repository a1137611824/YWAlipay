//
//  YWLifeViewController.swift
//  支付宝生活界面
//
//  Created by Mac on 2017/6/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWLifeViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
    }
    
    //MARK: - 界面
    private func setupUI() {
        self.title = "朋友圈"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.whiteColor()
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64))
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        let headView = YWLifeHeaderVeiw(frame: CGRectMake(0, 0, self.view.bounds.size.width, 170))
        tableView.tableHeaderView = headView
        self.view.addSubview(tableView)
        self.automaticallyAdjustsScrollViewInsets = false
        
        let nib = UINib(nibName: "YWLifeCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: lifeCell)
        
    }

   
    //MARK: - 懒加载
    lazy var YWMomentList = {
        return NSArray()
    }()
    
    //MARK: data 
    private func loadData() {
        let pathFile = NSBundle.mainBundle().pathForResource("moment", ofType: "plist")!
        let array = NSArray(contentsOfFile: pathFile)!
        
        let arrayM = NSMutableArray()
        for dict in array {
            let model = YWLifeModel.init(dict: dict as! NSDictionary)
            arrayM.addObject(model)
        }
        YWMomentList = arrayM.copy() as! NSArray
    }
}

//MARK: - delegate 
extension YWLifeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YWMomentList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(lifeCell, forIndexPath: indexPath) as! YWLifeCell
        cell.setModel(YWMomentList[indexPath.row] as! YWLifeModel)
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
    }
    
    
}








