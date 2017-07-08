//
//  ZFBCycleView.m
//  01-图片轮播器
//
//  Created by HM09 on 17/1/16.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "ZFBCycleView.h"
#import "ZFBCycleFlowLayout.h"
#import "Masonry.h"
#import "ZFBCycleCell.h"

@interface ZFBCycleView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

// 组数
#define ZFBCycleSectionCount 3
static NSString *CycleCellID = @"CycleCellID";
@implementation ZFBCycleView

// 如果当前这个类是通过xib或sb来创建的创建完成之后就会调用此方法
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}


// 重写initWithFrame:方法在此方法中创建及添加子控件
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

// 创建及添加子控件
- (void)setupUI {
    
    // 2.设置collectionView相关
    [self settingCollectionView];
    
    
    _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    /// 3.添加分页指示器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.6 alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.9 alpha:1];
//#warning mark - 知道有多少个图片之后再去设置
//    pageControl.numberOfPages = self.imageNames.count;
    [self addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
    }];
    
    _pageControl = pageControl;
}


#pragma mark - 定时器每两秒会执行的方法
- (void)nextPage {
    // 1.获取当前滚动到第几页了
    NSInteger page = self.pageControl.currentPage;
    
    NSIndexPath *scrollToPath;
    
    if (page == self.imageNames.count - 1) { // 当到了最后一页
        // 如果滚动到中间这一组的第后一页怎么办?
        // 如果当前滚动到中间这一组的最后一页,让它继续向下一组的第0个cell滚动
        scrollToPath = [NSIndexPath indexPathForItem:0 inSection:ZFBCycleSectionCount / 2 + 1];
    } else {
        // 如果不是在中间组的最后一页继续向下一页滚动
        scrollToPath = [NSIndexPath indexPathForItem:page + 1 inSection:ZFBCycleSectionCount / 2];
    }
    
    
    // 5.让collectionView中的cell滚动到指定索引
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
}
- (void)settingCollectionView {
    // 0.创建布局对象
    ZFBCycleFlowLayout *flowLayout = [[ZFBCycleFlowLayout alloc] init];
    // 1.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:collectionView];
    
    // 2.添加约束
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 3.设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 4.注册cell
    UINib *nib = [UINib nibWithNibName:@"ZFBCycleCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:CycleCellID];
    
    _collectionView = collectionView;
    

}

#pragma mark - 重写数据属性的set方法,当有了数据以后再去默认滚动到中间那一组的第0行
- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    
    
    _pageControl.numberOfPages = imageNames.count;
    
    
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:0 inSection:ZFBCycleSectionCount / 2];
    // 5.让collectionView默认显示中间这一组的第0个cell
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - 用代码的方式去滚动,滚动完一页停下来之后此方法会调用一次
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
    
    
}

#pragma mark - 此方法只有手动拖拽时当cell完全停下来才会调用一次
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //    NSLog(@"%@", self.collectionView.indexPathsForVisibleItems);
    //    NSLog(@"%f", scrollView.contentOffset.x);
    
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 当前界面上这个cell的组的索引
    NSInteger section = page / self.imageNames.count;
    // 当前界面上的cell的item索引
    NSInteger item = page % self.imageNames.count;
    
    // 如果当前还在中间这一组,那直接返回什么也不做
    if (section == ZFBCycleSectionCount / 2) return;
    
    
    // 要滚动到的索引
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:item inSection:ZFBCycleSectionCount / 2];
    // 5.让collectionView回滚到中间组的第item的cell上
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.4999;
    // 设置当前页
    _pageControl.currentPage =  page % self.imageNames.count;
    
}

#pragma mark - 将要开始拖拽时调用一次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 设置定时器开始执行的时间
    // 让它在未来的某个时间再去执行"假暂停"
    _timer.fireDate = [NSDate distantFuture];
    
}

#pragma mark - 当用户松开手之后让定时器重新执行
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 让定时器在2秒后开始执行
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];
    
}



#pragma mark - 数据源方法
// 返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ZFBCycleSectionCount;
}

// 返回每一组cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    ZFBCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CycleCellID forIndexPath:indexPath];
    // 2.设置数据
    cell.indexPath = indexPath;
    
    
    // 3.返回cell
    return cell;
}

#pragma mark - 当一个控件要从它的父控制上移除时就会调用此方法,但是调用此方法不代表控件就要销毁了
- (void)removeFromSuperview {
    [super removeFromSuperview];
//    NSLog(@"%s", __FUNCTION__);
    // 停止定时器,解出引用
    [_timer invalidate];
}
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}
@end
