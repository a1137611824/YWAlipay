//
//  forCodeScan.swift
//  AlipayProject
//
//  Created by Mac on 2017/4/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class forCodeScan: UIViewController {

    var forjump_URL = ""
    var forjump_bar_code = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        setupNavigationItem()
        if forjump_bar_code == "" {
            setupWebView()
        }else{
            setupLabel()
            
        }
    }
    
    func setupNavigationItem() {
        
        let btnR1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(forCodeScan.left_BarBtnClick))
        
        self.navigationItem.leftBarButtonItems = [btnR1]
    }
    
    func left_BarBtnClick() {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    func setupLabel() {
        let label = UILabel(frame: CGRectMake(100,100,300,20))
        self.view.addSubview(label)
        label.text = self.forjump_bar_code
        
    }
    
    func setupWebView() {
        let webView = UIWebView(frame: self.view.bounds)
        
        // 1. URL 定位资源,需要资源的地址
        let urlStr = self.forjump_URL
        let url = NSURL(string: urlStr)
        
        // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
        let request = NSURLRequest(URL: url!)
        
        // 3. 发送请求给服务器
        webView.loadRequest(request)
        self.view.addSubview(webView)
        
        
    }


   

}
