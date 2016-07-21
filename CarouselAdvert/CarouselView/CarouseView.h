//
//  CarouseView.h
//  CarouselAdvert
//
//  Created by Shao Jie on 16/7/20.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouseViewDelegate ;

@interface CarouseView : UIView
/**
 *  @brief 数据源
 */
@property (nonatomic,copy) NSMutableArray * dataArray;
/**
 *  @brief 未显示页的颜色，default 灰色
 */
@property (nonatomic,copy) UIColor * pageTintColor;
/**
 *  @brief 当前页的颜色  default 白色
 */
@property (nonatomic,copy) UIColor * currentPageTintColor;
/**
 *  @brief 轮播时间间隔
 */
@property (nonatomic,assign) CGFloat intervalTime;
/**
 *  @brief 是否自动播放
 */
@property (nonatomic,assign) BOOL isNeedAutoScroll;
@property (nonatomic,assign) id <CarouseViewDelegate> delegate;
- (void)autoStartAnimation;
@end
@protocol CarouseViewDelegate <NSObject>
@optional
- (void)CarouseView:(CarouseView *)carouseView clickNumber:(NSInteger)index;
@end