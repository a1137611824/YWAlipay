//
//  ZFBHomeViewController.swift
//  AlipayProject
//
//  Created by Mac on 2017/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBHomeViewController: UIViewController {

    
    var homeListView: UICollectionView!
    let homeListTopNum: Int = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.顶部功能区域
        let topview = ZFBTopView()
        topview.backgroundColor  = UIColor.colorWithHex(0x2e90d4)
        self.view.addSubview(topview)
        topview.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(115)
        }
        
        
        let functionListView = UIView()
        functionListView.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(functionListView)
        functionListView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(topview.snp_bottom).offset(0)
        }
        
        //添加按钮点击事件
        topview.scanBtn.addTarget(self, action: #selector(ZFBHomeViewController.scanBtnClick), forControlEvents: .TouchUpInside)
        topview.payBtn.addTarget(self, action: #selector(ZFBHomeViewController.payBtnClick), forControlEvents: .TouchUpInside)
        topview.cardBtn.addTarget(self, action: #selector(ZFBHomeViewController.cardBtnClick), forControlEvents: .TouchUpInside)
        topview.xiuxiuBtn.addTarget(self, action: #selector(ZFBHomeViewController.xiuxiuBtnClick), forControlEvents: .TouchUpInside)
        //设置压栈后的二级返回按钮
        let bar = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = bar

        
        setupHomeList()
        loadNibFile()
    }
    
    
    //MARK: -四个按钮的点击事件
    func scanBtnClick() {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ZFBCodeScanningPage(), animated: false)
        self.hidesBottomBarWhenPushed = false
    }
    
    func payBtnClick() {
        
    }
    
    func cardBtnClick() {
        
    }
    
    func xiuxiuBtnClick() {
        
    }
    
    //MARK: - listView功能页面
    //MARK: - 界面
    private func setupHomeList() {
        let flowLayout = YWHomeListFlowLayout()
        
        homeListView = UICollectionView(frame: CGRectMake(0, 115, SCREEN_WIDTH, SCREEN_HEIGHT - 115 - 49 - 44 - 20), collectionViewLayout: flowLayout)
        homeListView.delegate = self
        homeListView.dataSource = self
        self.view.addSubview(homeListView)
        
        homeListArray = YWHomeListModel.loadHomeListData()
        
    }
    
    //MARK: - 注册nib
    private func loadNibFile() {
        let homeListNib = UINib(nibName: "YWHomeListCell", bundle: nil)
        homeListView.registerNib(homeListNib, forCellWithReuseIdentifier: homeListCell)
        
        let homeListADNib = UINib(nibName: "YWHomeListADCell", bundle: nil)
        homeListView.registerNib(homeListADNib, forCellWithReuseIdentifier:homeListADCell)
    }
    
    //MARK: - 懒加载
    lazy var homeListArray: NSArray = {
        return NSArray()
    }()
    
    //MARK: - 创建可变数组用来保存图片名称
    private func loadImageNames() -> NSArray {
        let arrayM = NSMutableArray(capacity: 5)
        for i in 0..<5 {
            arrayM.addObject(i.description)
        }
        return arrayM
    }



}

//MARK: - delegate
extension ZFBHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return homeListTopNum
        }else if section == 1 {
            return 1
        }
        return homeListArray.count - homeListTopNum
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let ADCell = collectionView.dequeueReusableCellWithReuseIdentifier(homeListADCell, forIndexPath: indexPath) as! YWHomeListADCell
            ADCell.setImageNames(loadImageNames())
            return ADCell
        }
        let ListCell = collectionView.dequeueReusableCellWithReuseIdentifier(homeListCell, forIndexPath: indexPath) as! YWHomeListCell
        if indexPath.section == 0 {
            ListCell.setModel(homeListArray[indexPath.row] as! YWHomeListModel)
        }else{
            ListCell.setModel(homeListArray[indexPath.row + homeListTopNum] as! YWHomeListModel)
        }
        
        return ListCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewW = collectionView.bounds.size.width
        
        if indexPath.section == 1 {
            return CGSizeMake(collectionViewW, 100)
        }
        let itemW = (collectionViewW - 3)/4
        return CGSizeMake(itemW, itemW)
    }
        
}
