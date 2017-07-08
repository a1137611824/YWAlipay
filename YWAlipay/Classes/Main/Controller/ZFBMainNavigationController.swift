//
//  ZFBMainNavigationController.swift
//  AlipayProject
//
//  Created by Mac on 2017/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBMainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航栏上的标题文字颜色
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(15.0)]
        
        // 2.以下两行代码可以把导航栏下面的阴影线去掉
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barTintColor = UIColor.colorWithHex(0x2e90d4)
        
        //关闭半透明效果
        self.navigationBar.translucent = false
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    

}
