//
//  YWHomeListController.swift
//  商家分类
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWHomeListController: UIViewController {

    var homeListView: UICollectionView!
    let homeListTopNum: Int = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHomeList()
        loadNibFile()
    }
    
    //MARK: - 界面
    private func setupHomeList() {
        let flowLayout = YWHomeListFlowLayout()
        homeListView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
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
extension YWHomeListController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
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

