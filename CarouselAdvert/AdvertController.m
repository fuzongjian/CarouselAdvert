//
//  AdvertController.m
//  CarouselAdvert
//
//  Created by Shao Jie on 16/7/21.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import "AdvertController.h"
#import "CarouseView.h"
@interface AdvertController ()
@property (nonatomic,strong) CarouseView * carouseView;
@end

@implementation AdvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.carouseView];
    
    // Do any additional setup after loading the view.
}
- (CarouseView *)carouseView{
    if (_carouseView == nil) {
        _carouseView = [[CarouseView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
        NSMutableArray * dataArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"1.jpg",@"2.jpg",@"3.jpg", nil];
        _carouseView.dataArray = dataArray;
        _carouseView.backgroundColor = [UIColor redColor];
        _carouseView.intervalTime = 1;
    }
    return _carouseView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
