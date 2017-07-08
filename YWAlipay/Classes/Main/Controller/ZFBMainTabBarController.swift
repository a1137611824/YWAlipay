//
//  ZFBMainTabBarController.swift
//  AlipayProject
//
//  Created by Mac on 2017/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAllChirldViewController()
    }
    
    //初始化所有子控制器
    func setUpAllChirldViewController() {
        //首页
        tabBarAddChildViewController(ZFBHomeViewController(), title: "首页", imageName: "TabBar_HomeBar", selectedImageName: "TabBar_HomeBar_Sel")
        //口碑
        tabBarAddChildstoryBoradName("ZFBBusinessViewController", title: "口碑", imageName: "TabBar_Businesses", selectedImageName: "TabBar_Businesses_Sel")
        //朋友
        tabBarAddChildClassName("ZFBFriendsViewController", title: "朋友", imageName: "TabBar_Friends", selectedImageName: "TabBar_Friends_Sel")
        //我的
        tabBarAddChildViewController(ZFBMineViewController(), title: "我的", imageName: "TabBar_Assets", selectedImageName: "TabBar_Assets_Sel")
        
        //设置标签栏颜色(不设置自动合图片颜色相同)
        self.tabBar.tintColor = UIColor.colorWithHex(0x2e90d4)
        self.tabBar.translucent = false
        
        
    }
    //MARK: - 加载storyboard
    func tabBarAddChildstoryBoradName(sbName: String, title: String, imageName: String, selectedImageName: String) {
        //加载指定名称的sb文件
        let sb = UIStoryboard(name: sbName, bundle: nil)
        let vc = sb.instantiateInitialViewController()
        
        //由storyboard进入
        vc!.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc!.view.backgroundColor = UIColor.whiteColor()
        
        let nav = ZFBMainNavigationController(rootViewController: vc!)
        vc!.navigationItem.title = title
        addChildViewController(nav)

    }
    
    //MARK: -加载类名
    func tabBarAddChildClassName(vcName: String, title: String, imageName: String, selectedImageName: String) {
        //获取命名空间
        let clsName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"]
        //把字符串形式的类名称转换成类
        let forClass: AnyClass? = NSClassFromString(clsName as! String + "." + vcName )
        let vcforClass = forClass as! UIViewController.Type
        //通过class创建对象
        let vc = vcforClass.init()
        
        //由viewcontroller直接添加
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc.view.backgroundColor = UIColor.whiteColor()
        
        let nav = ZFBMainNavigationController(rootViewController: vc)
        vc.navigationItem.title = title
        addChildViewController(nav)
        
    }
    
    //MARK: -加载swift文件
    func tabBarAddChildViewController(vc: UIViewController, title: String, imageName: String, selectedImageName: String){
        
        
        //由viewcontroller直接添加
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc.view.backgroundColor = UIColor.whiteColor()
        
        let nav = ZFBMainNavigationController(rootViewController: vc)
        vc.navigationItem.title = title
        addChildViewController(nav)

    }
    

   

}
