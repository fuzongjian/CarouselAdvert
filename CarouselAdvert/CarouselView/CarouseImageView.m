//
//  CarouseImageView.m
//  CarouselAdvert
//
//  Created by Shao Jie on 16/7/20.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import "CarouseImageView.h"
@interface CarouseImageView ()
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * titleLable;
@end
@implementation CarouseImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLable];
    }
    return self;
}
- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    if ([imageUrl hasPrefix:@"http"]) {
        
    }else{
        self.imageView.image = [UIImage imageNamed:imageUrl];
    }
}
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.titleLable.text = titleString;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * 0.8, self.bounds.size.width, self.bounds.size.height * 0.2)];
        _titleLable.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:1 alpha:0.5];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont systemFontOfSize:self.bounds.size.height * 0.1];
        _titleLable.text = @"  虚怀若谷，求知若渴";
    }
    return _titleLable;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
