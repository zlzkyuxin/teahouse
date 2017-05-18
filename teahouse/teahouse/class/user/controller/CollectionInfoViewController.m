//
//  CollectionInfoViewController.m
//  teahouse
//
//  Created by yuxin on 2017/5/17.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "CollectionInfoViewController.h"

@interface CollectionInfoViewController ()

@end

@implementation CollectionInfoViewController

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
    self.title = @"我的收藏";
}

@end
