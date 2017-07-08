//
//  NSAttributedString+Extension.swift
//  AlipayProject
//
//  Created by Mac on 2017/4/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

// MARK: -使用图像和文本生成上下排列的属性文本
extension NSAttributedString {
    
    class func imageTextInit(image: UIImage, imageWH: CGFloat, labelTitle: String, fontSize: CGFloat, titleColor: UIColor, labelSpacing: CGFloat) -> NSAttributedString{

        //图片文本
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRectMake(0, 0, imageWH, imageWH)
        let imageText = NSAttributedString(attachment: attachment)
        
        //标题文本
        let titleDict = [NSFontAttributeName: UIFont.systemFontOfSize(fontSize), NSForegroundColorAttributeName: titleColor]
        let text = NSAttributedString(string: labelTitle, attributes: titleDict)
        
        //换行文本
        let spaceDict = [NSFontAttributeName:UIFont.systemFontOfSize(labelSpacing)]
        let lineText = NSAttributedString(string: "\n\n", attributes: spaceDict)
        
        
        //合并文字
        let mutableAttr = NSMutableAttributedString(attributedString: imageText)
        mutableAttr.appendAttributedString(lineText)
        mutableAttr.appendAttributedString(text)

        return mutableAttr.copy() as! NSAttributedString
    }

}








