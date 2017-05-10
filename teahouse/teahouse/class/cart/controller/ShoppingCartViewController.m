//
//  ShoppingCartViewController.m
//  teahouse
//
//  Created by zlzk on 2017/5/5.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "ShoppingCartViewController.h"

@interface ShoppingCartViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    UITableView *_tableView;
}
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
