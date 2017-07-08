//
//  ZFBPictureView.swift
//  Alipay-business
//
//  Created by Mac on 2017/4/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBPictureView: UIView {

    class func headerView() -> ZFBPictureView {
        let headerView = NSBundle.mainBundle().loadNibNamed("ZFBPictureView", owner: nil, options: nil)?.first as! ZFBPictureView
        return headerView
    }
    
    

}
