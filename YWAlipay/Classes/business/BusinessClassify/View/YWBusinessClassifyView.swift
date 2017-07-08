//
//  YWBusinessClassifyView.swift
//  YWAlipay
//
//  Created by Mac on 2017/6/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

let ID = "bussinessClassify"
protocol YWBusinessClassifyViewDelegate {
    func didSelectRow(row: Int)
}

class YWBusinessClassifyView: UIView {
    
    var businessClassifyData: NSArray!
    var pageController: UIPageControl!
    var delegate: YWBusinessClassifyViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    //MARK: - 界面
    private func setupUI() {
        //1.创建collectionView并赋值layout
        let flowLayout = YWBusinessClassifyFlowLayout()
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        self.addSubview(collectionView)
        
        //2.添加collectionView的约束
        collectionView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(150)
        }
        
        //3.注册获取cell
        collectionView.registerClass(YWBussinessClassifyCell.self, forCellWithReuseIdentifier: ID)
        
        //4设置pageControll，当前page，numberPage，pageIndictor的颜色-默认和选中--，以及enabled为no
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.pageIndicatorTintColor = UIColor(white: 0.9, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor(white: 0.1, alpha: 1)
        self.pageController = pageControl
        self.addSubview(pageControl)
        
        pageControl.snp_makeConstraints { (make) in
            make.top.equalTo(collectionView.snp_bottom).offset(0)
            make.centerX.equalTo(0)
        }
    }
    
}

//MARK: - delegate
extension YWBusinessClassifyView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.4999)
        self.pageController.currentPage = page
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.businessClassifyData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! YWBussinessClassifyCell
        cell.setBussinessClassify(self.businessClassifyData[indexPath.item] as! YWBussinessClassifyModel)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if delegate != nil {
            self.delegate.didSelectRow(indexPath.row)
        }
        
    }
    
    
}
