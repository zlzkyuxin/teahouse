//
//  OrderListViewController.m
//  teahouse
//
//  Created by yuxin on 2017/4/15.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderNumberTableViewCell.h"
#import "OrderPayViewController.h"
#import "LoginModel.h"
#import "OrderModel.h"

@interface OrderListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    UITableView *_tableView;
    NSArray *dataArray;
    NSArray *dataSource;
    LoginModel *userInfo;
}
@property (nonatomic , strong) NSString *goodsNumber;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self loadData];
    //初始化界面
    [self initView];
}

//初始化数据
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化表格
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //初始化右上角提交按钮
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [right setTitle:@"提交" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
}

//初始化数据
- (void)loadData {
    //取出绑定手机号码
    NSString *phone = [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"];
    NSString *tel = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    dataArray = @[@[self.goodsName,@"",@"小计"],@[@"抵用券",@"订单总价"],@[@"您绑定的手机号码",tel]];
    dataSource = @[@[[NSString stringWithFormat:@"%d元",[self.price intValue]],@"",[NSString stringWithFormat:@"￥%.1f",[self.price floatValue]]],@[@"",[NSString stringWithFormat:@"￥%.1f",[self.price floatValue]]],@[@"",@"绑定新号码"]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else {
        return 2;
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf)
    //设置默认数量
    self.goodsNumber = @"1";
    __block NSString *numbers = @"1";
    if (indexPath.section == 0 && indexPath.row == 1) {
        OrderNumberTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderNumberTableViewCell" owner:self options:nil] firstObject];
        //监听数量变化
        cell.block = ^(int number) {
            numbers = [NSString stringWithFormat:@"%d",number];
            dataSource = @[@[[NSString stringWithFormat:@"%d元",[self.price intValue]],@"",[NSString stringWithFormat:@"￥%.1f",[self.price floatValue] * number]],@[@"",[NSString stringWithFormat:@"￥%.1f",[self.price floatValue] * number]],@[@"",@"绑定新号码"]];
            //刷新其中总价的cell
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:1 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
            weakSelf.goodsNumber = numbers;
        };
        //设置变化后的数量
        cell.numberField.text = numbers;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = dataSource[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ((indexPath.section == 1 && indexPath.row == 0) |
            (indexPath.section == 2 && indexPath.row == 1)) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - 提交按钮的点击事件
- (void)commitClick {
    NSLog(@"%@--%@",self.price,self.goodsNumber);
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    if (dic) {
        userInfo = [LoginModel mj_objectWithKeyValues:dic];
    }
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{
                @"key":@"createOrder",
                @"goodID":self.goodsID,
                @"userID":userInfo.userID,
                @"goodsNumber":self.goodsNumber,
                @"goodsPrice":self.price,
                };
    [[TeaHouseNetWorking shareNetWorking] POST:@"order.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"%@",result);
        if ([result[@"code"] intValue] == 200) {
            OrderModel *orderModel = [OrderModel mj_objectWithKeyValues:result[@"list"]];
            NSLog(@"%@",orderModel.orderID);
            OrderPayViewController *nextVC = [OrderPayViewController new];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
