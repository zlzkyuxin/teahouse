//
//  OrderListViewController.m
//  teahouse
//
//  Created by yuxin on 2017/4/15.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderNumberTableViewCell.h"

@interface OrderListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    UITableView *_tableView;
    NSArray *dataArray;
    NSArray *dataSource;
}
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)loadData {
    NSString *phone = [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"];
    NSString *tel = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    dataArray = @[@[self.goodsName,@"",@"小计"],@[@"抵用券",@"订单总价"],@[@"您绑定的手机号码",tel]];
    dataSource = @[@[[NSString stringWithFormat:@"%d元",[self.price intValue]],@"",[NSString stringWithFormat:@"￥%.1f",[self.price floatValue]]],@[@"",[NSString stringWithFormat:@"￥%.1f",[self.price floatValue]]],@[@"",@"绑定新号码"]];
}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
//        [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailTableViewCellB" owner:self options:nil] firstObject];
        OrderNumberTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderNumberTableViewCell" owner:self options:nil] firstObject];
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

@end