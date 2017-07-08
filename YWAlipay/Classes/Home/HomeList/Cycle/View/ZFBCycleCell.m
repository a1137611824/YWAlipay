//
//  ZFBCycleCell.m
//  01-图片轮播器
//
//  Created by HM09 on 17/1/16.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "ZFBCycleCell.h"

@interface ZFBCycleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end
@implementation ZFBCycleCell

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    self.iconView.image = [UIImage imageNamed:@(indexPath.item).description];

}

@end
