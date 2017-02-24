//
//  GoodsDetailViewController.m
//  teahouse
//
//  Created by yuxin on 2017/2/22.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailModel.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadData {
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"key":@"goodsDetails",@"goodsID":self.goodsId};
    [[TeaHouseNetWorking shareNetWorking] POST:@"shopgoods.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
         NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"%@",result);
        GoodsDetailModel *model = [GoodsDetailModel mj_objectWithKeyValues:[result[@"list"] firstObject]];
        NSLog(@"%@",model);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
