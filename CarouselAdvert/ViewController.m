//
//  ViewController.m
//  CarouselAdvert
//
//  Created by Shao Jie on 16/7/20.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import "ViewController.h"
#import "AdvertController.h"
#import "CarouselView/CarouseView.h"
@interface ViewController ()<CarouseViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) CarouseView * carouseView;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;

//    [self.view addSubview:self.carouseView];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cell_id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d---行",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AdvertController * advertController = [[AdvertController alloc] init];
    [self.navigationController pushViewController:advertController animated:YES];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.carouseView;
    }
    return _tableView;
}



- (void)CarouseView:(CarouseView *)carouseView clickNumber:(NSInteger)index{
//    [carouseView removeFromSuperview];
    AdvertController * advertController = [[AdvertController alloc] init];
    [self.navigationController pushViewController:advertController animated:YES];
    NSLog(@"%@---%d",carouseView,index);
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.carouseView autoStartAnimation];
}
- (CarouseView *)carouseView{
    if (_carouseView == nil) {
        _carouseView = [[CarouseView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
        NSMutableArray * dataArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"1.jpg",@"2.jpg",@"3.jpg", nil];
        _carouseView.dataArray = dataArray;
        _carouseView.backgroundColor = [UIColor redColor];
        _carouseView.delegate = self;
        _carouseView.intervalTime = 1;
    }
    return _carouseView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
