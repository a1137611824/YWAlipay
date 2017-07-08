//
//  ZFBCycleFlowLayout.m
//  01-图片轮播器
//
//  Created by HM09 on 17/1/16.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "ZFBCycleFlowLayout.h"

@implementation ZFBCycleFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    // 让cell的大小和collectionView一样大
    self.itemSize = self.collectionView.bounds.size;
    // 清空最小列和行间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    // 更改滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 开启分页
    self.collectionView.pagingEnabled = YES;
    // 隐藏滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 关闭弹簧效果
    self.collectionView.bounces = NO;
}
@end
