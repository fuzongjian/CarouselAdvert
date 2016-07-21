//
//  CarouseImageView.h
//  CarouselAdvert
//
//  Created by Shao Jie on 16/7/20.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouseImageView : UIControl
/**
 *  @brief 图片路径或者图片名字
 */
@property (nonatomic,copy) NSString * imageUrl;
@property (nonatomic,strong) UIImage * placeholderImage;
@property (nonatomic,strong) NSString * titleString;
@end
