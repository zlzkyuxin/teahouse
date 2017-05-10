//
//  ShoppingCartViewController.m
//  teahouse
//
//  Created by zlzk on 2017/5/5.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "GoodsDetailViewController.h"
#import "ShoppingCartModel.h"
#import "LoginModel.h"

@interface ShoppingCartViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    UITableView *_tableView;
    
    LoginModel *userInfo;
    
    NSMutableArray *shopCartArray;
}
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self loadData];
    //初始化界面
    [self initView];
}

//初始化数据
- (void)loadData {
    shopCartArray = @[].mutableCopy;
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    NSString *userID = @"1";
    if (dic != nil) {
        userInfo = [LoginModel mj_objectWithKeyValues:dic];
        userID = userInfo.userID;
    }
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"key":@"orderFromUserID",@"userID":userID,@"orderState":@"待付款"};
    [[TeaHouseNetWorking shareNetWorking] POST:@"order.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        if ([result[@"code"] intValue] == 200) {
            for (NSDictionary *dic in result[@"list"]) {
                ShoppingCartModel *shopCartModel = [ShoppingCartModel mj_objectWithKeyValues:dic];
                [shopCartArray addObject:shopCartModel];
            }
            [_tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//初始化界面
- (void)initView {
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return shopCartArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartTableViewCell" owner:self options:nil] firstObject];
    }
    cell.shopCartModel = (ShoppingCartModel *)shopCartArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailViewController *nextVC = [GoodsDetailViewController new];
    ShoppingCartModel *model = shopCartArray[indexPath.row];
    nextVC.goodsId = model.goodID;
    nextVC.title = model.goodsName;
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
