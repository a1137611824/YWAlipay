//
//  UIColor+Extension.swift
//  AlipayProject
//
//  Created by Mac on 2017/3/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor{
        return UIColor(red: CGFloat(arc4random()%255) / 255.0, green: CGFloat(arc4random()%255) / 255.0, blue: CGFloat(arc4random()%255) / 255.0, alpha: 1)
    }
    
    //用hex值来定义颜色
    class func colorWithHex(hex: UInt32) -> UIColor{
        let r = (hex & 0xff0000) >> 16    //高两位
        let g = (hex & 0x00ff00) >> 8     //中间两位
        let b = hex & 0x0000ff
        return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
    }

    
    
    
    
}

