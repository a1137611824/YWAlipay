//
//  ZFBMineViewController.swift
//  AlipayProject
//
//  Created by Mac on 2017/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBMineViewController: UIViewController {

//    var mineTableView: UITableView!
    var mineCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configCollectionView()
        configUI()
    }

    //MARK: - 界面
    private func configUI() {
        let nib = UINib(nibName: "ZFBMineHeadView", bundle: nil)
        mineCollectionView.registerNib(nib, forCellWithReuseIdentifier: mineHeadView)
        let nib2 = UINib(nibName: "ZFBMineBalanceView", bundle: nil)
        mineCollectionView.registerNib(nib2, forCellWithReuseIdentifier: mineBalanceView)
        let nib3 = UINib(nibName: "ZFBMineContentView", bundle: nil)
        mineCollectionView.registerNib(nib3, forCellWithReuseIdentifier: mineContenView)
    }
    
    private func configCollectionView() {
        let flowLayout = ZFBMineFlowLayout()
        mineCollectionView = UICollectionView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 44), collectionViewLayout: flowLayout)
        mineCollectionView.delegate = self
        mineCollectionView.dataSource = self
        self.view.addSubview(mineCollectionView)
        dataArray = ZFBMineOptionModel.loadMineModel()
    }
    
    //MARK: - 懒加载
    lazy var dataArray: NSArray = {
        return NSArray()
    }()

}


extension ZFBMineViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if section == 1 { return 5 }
        if section == 2 { return 4 }
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let headCell = collectionView.dequeueReusableCellWithReuseIdentifier(mineHeadView, forIndexPath: indexPath) as! ZFBMineHeadView
            
            return headCell
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            let balanceCell = collectionView.dequeueReusableCellWithReuseIdentifier(mineBalanceView, forIndexPath: indexPath) as! ZFBMineBalanceView
            return balanceCell
        }
    
        let contentCell = collectionView.dequeueReusableCellWithReuseIdentifier(mineContenView, forIndexPath: indexPath) as! ZFBMineContentView
        
        
        var mineOption: ZFBMineOptionModel!
        if indexPath.section == 1 {
            mineOption = dataArray[indexPath.item - 1] as! ZFBMineOptionModel
        }else if indexPath.section == 2 {
            mineOption = dataArray[indexPath.item + 4] as! ZFBMineOptionModel
        }else if indexPath.section == 3 {
            mineOption = dataArray[indexPath.item + 8] as! ZFBMineOptionModel
        }
        
        contentCell.setModel(mineOption)
        return contentCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewW = collectionView.bounds.size.width
        
        if indexPath.section == 0 {
            return CGSizeMake(collectionViewW, 100)
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            return CGSizeMake(collectionViewW, 68)
        }
        
        return CGSizeMake((collectionViewW - 1)/2, 68)
    }
}




////MARK: - delegate
//extension ZFBMineViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 4
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 1 {return 2}
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCellWithIdentifier(mineHeadView, forIndexPath: indexPath) as! ZFBMineHeadView
//            return cell
//        }else{
//            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
//            if cell == nil {
//                cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
//            }
//            
//            return cell!
//        }
//        
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//    }
//    
//}




