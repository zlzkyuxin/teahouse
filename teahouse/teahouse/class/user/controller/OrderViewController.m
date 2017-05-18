//
//  OrderViewController.m
//  teahouse
//
//  Created by yuxin on 2017/5/18.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //显示navigationbar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self loadData];
    //初始化界面
    [self initView];
}

//初始化数据
- (void)loadData {
    
}

//初始化界面
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的订单";
}
@end
