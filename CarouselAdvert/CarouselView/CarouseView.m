//
//  CarouseView.m
//  CarouselAdvert
//
//  Created by Shao Jie on 16/7/20.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import "CarouseView.h"
#import "CarouseImageView.h"
#define WIDTH_AD self.frame.size.width
#define HEIGHT_AD self.frame.size.height
@interface CarouseView ()<UIScrollViewDelegate>
/**
 *  @brief 图片轮播器
 */
@property (strong,nonatomic) UIScrollView * scrollView;
/**
 *  @brief 页码控制器
 */
@property (strong,nonatomic) UIPageControl * pageControl;
/**
 *  @brief 定时器
 */
@property (strong,nonatomic) NSTimer * timer;
@property (assign,nonatomic) CGFloat lastContentX;
/**
 *  @brief 当前页面
 */
@property (nonatomic,assign) NSInteger currentPage;
/**
 *  @brief 广告页数
 */
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) NSMutableArray * imageViewsArray;
@end
@implementation CarouseView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pageTintColor = [UIColor whiteColor];
        _currentPageTintColor = [UIColor redColor];
        _intervalTime = 2.0;
        _isNeedAutoScroll = YES;
    }
    return self;
}
- (void)startAnimation{
    if (self.isNeedAutoScroll && !_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime target:self selector:@selector(autoStartAnimation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }else{
//        [self autoStartAnimation];
    }
}
- (void)stopAnimation{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)autoStartAnimation{
    [self.scrollView setContentOffset:CGPointMake(WIDTH_AD * 2, 0) animated:YES];
}
#pragma mark --- UIScrollView  Delegate
/**
 *  @brief 开始拖动，停止自动滚动
 *
 *  @param scrollView 图片轮播器
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self stopAnimation];
}
/**
 *  @brief 拖动停止
 *
 *  @param scrollView 图片轮播器
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x - self.lastContentX;
    NSUInteger index = fabs(x) / WIDTH_AD;
    if (index == 1) {
        BOOL isRight = (x > 0);
        if (self.isNeedAutoScroll || (!(self.currentPage == self.count -1 && isRight) && !(self.currentPage == 0 && !isRight))) {
            [self adjustPage:isRight];
        }
        
        BOOL isNeedAdjust = !((self.currentPage == self.count -1) ||(self.currentPage == self.count - 2 && !isRight) || (self.currentPage == 0) || (self.currentPage == 1 && isRight));
        if (self.isNeedAutoScroll || isNeedAdjust) {
            
            [self adjustImageViewImage:isRight];
            
            [self adjustImageView];
        }
        
        // 不是自动播放
        if (!self.isNeedAutoScroll) {
            [self adjustLastContentX];
        }
    }
}
- (void)adjustPage:(BOOL)isRight{
    if (isRight) {
        if (self.currentPage == self.count -1) {
            self.pageControl.currentPage = 0;
            return;
        }
        self.pageControl.currentPage += 1;
        return;
    }
    
    if (self.currentPage == 0) {
        self.pageControl.currentPage = self.count - 1;
        return;
    }
    self.pageControl.currentPage -= 1;
}
- (void) adjustLastContentX{
    if (self.currentPage == self.count - 1) {
        self.lastContentX = WIDTH_AD *2;
    }else if (self.currentPage == 0){
        self.lastContentX = 0;
    }else{
        self.lastContentX = WIDTH_AD;
    }
}
- (void)adjustImageView{
    [self.scrollView setContentOffset:CGPointMake(WIDTH_AD, 0)];
}
- (void)adjustImageViewImage:(BOOL)isRight{
    
    int lastIndex = (int)self.count -1;
    
    if (isRight) {
        NSString * firstData = [self.dataArray objectAtIndex:0];
        for (int i = 0; i < lastIndex + 1; i ++) {
            self.dataArray[i] = i == lastIndex ? firstData:self.dataArray[i+1];
        }
    }else{
        NSString * lastData = [self.dataArray objectAtIndex:lastIndex];
        for (int i = lastIndex; i >= 0; i --) {
            self.dataArray[i] = i==0?lastData:self.dataArray[i-1];
        }
    }
    for (int i =0; i < self.count; i ++) {
        CarouseImageView * imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.imageUrl = [self.dataArray objectAtIndex:i];
    }
}
- (NSMutableArray *)imageViewsArray{
    if (_imageViewsArray == nil) {
        _imageViewsArray = [NSMutableArray array];
        for (int i = 0; i < self.dataArray.count; i ++) {
            CarouseImageView * imageView = [[CarouseImageView alloc] initWithFrame:CGRectMake(WIDTH_AD * i, 0, WIDTH_AD, HEIGHT_AD)];
            [imageView addTarget:self action:@selector(imageViewClicked) forControlEvents:UIControlEventTouchUpInside];
            [_imageViewsArray addObject:imageView];
        }
    }
    return _imageViewsArray;
}
- (NSInteger)currentPage{
    return self.pageControl.currentPage;
}
#pragma mark --- 轮播开启的位置
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    self.count = dataArray.count;
    if (dataArray.count <= 0) return;
    if (dataArray.count == 1) {
        CarouseImageView * imageView = [[CarouseImageView alloc] initWithFrame:self.bounds];
        [imageView addTarget:self action:@selector(imageViewClicked) forControlEvents:UIControlEventTouchUpInside];
        imageView.imageUrl = [self.dataArray objectAtIndex:0];
        [self addSubview:imageView];
        return ;
    }
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self startAnimation];
    
}
- (void)imageViewClicked{
    if ([self.delegate conformsToProtocol:@protocol(CarouseViewDelegate)] && [self.delegate respondsToSelector:@selector(CarouseView:clickNumber:)]) {
        [self.delegate CarouseView:self clickNumber:self.currentPage];
    }
}
- (void)setIsNeedAutoScroll:(BOOL)isNeedAutoScroll{
    _isNeedAutoScroll = isNeedAutoScroll;
    if (self.count < 2) {
        return;
    }
    if (isNeedAutoScroll) {
        [self startAnimation];
        return;
    }else{
        [self stopAnimation];
    }
}
- (void)setCurrentPageTintColor:(UIColor *)currentPageTintColor{
    _currentPageTintColor = currentPageTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageTintColor;
}
- (void)setPageTintColor:(UIColor *)pageTintColor{
    _pageTintColor = pageTintColor;
    self.pageControl.pageIndicatorTintColor = pageTintColor;
}
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.lastContentX = WIDTH_AD;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(WIDTH_AD * self.count, HEIGHT_AD);
        
        for (int i = 0; i < self.count; i ++) {
            CarouseImageView * imageView = [self.imageViewsArray objectAtIndex:i];
            imageView.imageUrl = [self.dataArray objectAtIndex:i];
            [_scrollView addSubview:imageView];
        }
        [_scrollView setContentOffset:CGPointMake(WIDTH_AD, 0)];
    }
    return _scrollView;
}
- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH_AD * 0.5, HEIGHT_AD * 0.9, WIDTH_AD * 0.5, HEIGHT_AD * 0.1)];
//        _pageControl.backgroundColor = [UIColor grayColor];
        _pageControl.pageIndicatorTintColor = self.pageTintColor;
        _pageControl.currentPageIndicatorTintColor = self.currentPageTintColor;
        
        _pageControl.numberOfPages = self.count;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
