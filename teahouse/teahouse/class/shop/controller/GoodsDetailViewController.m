//
//  GoodsDetailViewController.m
//  teahouse
//
//  Created by yuxin on 2017/2/22.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailModel.h"
#import "GoodsDetailTableViewCellA.h"
#import "GoodsDetailTableViewCellB.h"
#import "OrderListViewController.h"
#import "LoginViewController.h"
//#import "LoopBanner.h"

@interface GoodsDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    UIImageView *topImage;
    UITableView *_tableView;
    GoodsDetailModel *goodsDeailModel;
}

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"粟粟";
    [self initView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
//    LoopBanner *loop = [[LoopBanner alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) scrollDuration:0];
//    loop.imageURLStrings = @[@"home1.jpg",@"home2.jpg",@"home3.jpg",@"home4.jpg"];
//    loop.clickAction = ^(NSInteger index) {
//        TEALog(@"点击了第%ld张图片",(long)index);
//    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (160.0/568.0)*SCREEN_HEIGHT)];
    _tableView.tableHeaderView = topImage;
}

//数据请求
- (void)loadData {
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    if (!_goodsId) {
        loadDic = @{@"key":@"goodsSearch",@"goodName":self.title};
    }else {
        loadDic = @{@"key":@"goodsDetails",@"goodsID":self.goodsId};
    }
    
    [TeaHouseNetWorking POST:@"shopgoods.php" showHUD:YES  showMessage:@"商品查询中" parameters:loadDic success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            goodsDeailModel = [GoodsDetailModel mj_objectWithKeyValues:[responseObject[@"list"] firstObject]];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/original/%@.png",ImageURL,goodsDeailModel.goodsImageName]];
            //            NSURL *url = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/wh%3D900%2C900/sign=e9ca6c55a0014c08196e20ac3a4b2e31/81cb39dbb6fd5266d0f8dde8a218972bd507367e.jpg" ];
            //            NSURL *url = [NSURL URLWithString:@"http://10.37.26.26/TeaAPP/images/susu.jpg"];
            [topImage sd_setImageWithURL:url];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [self createBackgroundImage:[UIImage imageNamed:@"failurelode"] title:@"" withResponseResult:TeaResponseError onView:self.view];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       if (indexPath.row == 1 |
    indexPath.row == 3 |
    indexPath.row == 7 |
    indexPath.row == 11 |
    indexPath.row == 14 |
    indexPath.row == 19) {
        
           return 5;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";

    if (indexPath.row == 0) {
        GoodsDetailTableViewCellB *cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailTableViewCellB" owner:self options:nil] firstObject];
        cell.block = ^() {
            
            TEALog(@"21312312");
        };
        cell.goodsNumber.text = [NSString stringWithFormat:@"剩余%@件",goodsDeailModel.goodsNumber];
        //cell分割线左移到顶
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
    
        if (indexPath.row == 0 |indexPath.row == 1 |
            indexPath.row == 2 |indexPath.row == 3 |
            indexPath.row == 6 |indexPath.row == 7 |
            indexPath.row == 10 |indexPath.row == 11 |
            indexPath.row == 13 |indexPath.row == 14 |
            indexPath.row == 18 |indexPath.row == 19) {
            //cell分割线左移到顶
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        if (indexPath.row == 1 |
            indexPath.row == 3 |
            indexPath.row == 7 |
            indexPath.row == 11 |
            indexPath.row == 14 |
            indexPath.row == 19) {
            
            cell.contentView.backgroundColor = SETRGBColor(230, 230, 230);
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    headerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    //最新价格
    UILabel *price = [UILabel new];
    [headerView addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(10);
        make.top.equalTo(headerView).offset(10);
        make.bottom.equalTo(headerView).offset(-10);
    }];
    price.adjustsFontSizeToFitWidth = YES;
    
    NSString *goodsPrice = @"";
    if ([goodsDeailModel.goodsIsDiscount intValue] == 0) {
        goodsPrice = [NSString stringWithFormat:@"￥%.1f",[goodsDeailModel.goodsPrice floatValue]];
    }else {
        goodsPrice = [NSString stringWithFormat:@"￥%.2f",[goodsDeailModel.goodsPrice floatValue] * 0.75];
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:goodsPrice];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(1, att.length-1)];
    price.attributedText = att;
    price.textColor = [UIColor greenColor];
    
    //
    UILabel *prices = [UILabel new];
    [headerView addSubview:prices];
    [prices mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(price.mas_right).offset(5);
        make.top.equalTo(price);
        make.bottom.equalTo(price);
    }];
    NSString *nowPrice = [NSString stringWithFormat:@"门市价:￥%.1f",[goodsDeailModel.goodsPrice floatValue]];
    prices.adjustsFontSizeToFitWidth = YES;
    prices.text = nowPrice;
    prices.font = [UIFont systemFontOfSize:15];
    prices.textColor = [UIColor lightGrayColor];
    //是否隐藏原价
    if ([goodsDeailModel.goodsIsDiscount intValue] == 0) {
        prices.hidden = YES;
    }else {
        prices.hidden = NO;
    }
    
    //立即抢购
    UIButton *buyBtn = [UIButton new];
    [headerView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-15);
        make.top.equalTo(headerView).offset(15);
        make.bottom.equalTo(headerView).offset(-15);
    }];
    [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:[[UIColor orangeColor] colorWithAlphaComponent:1]];
    [buyBtn.layer setCornerRadius:3];
    [buyBtn.layer setMasksToBounds:YES];
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //
    UILabel *line = [UILabel new];
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView);
        make.right.equalTo(headerView);
        make.bottom.equalTo(headerView);
        make.height.mas_offset(@0.5);
    }];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    return headerView;
}


- (void)buyBtnClick {
    TEALog(@"立即抢购");
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"islogin"]) {
        [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    }else {
        OrderListViewController *nextVC = [OrderListViewController new];
        nextVC.title = @"提交订单";
        nextVC.goodsID = goodsDeailModel.goodsID;
        nextVC.goodsName = goodsDeailModel.goodsName;
        NSString *goodPrice = @"";
        if ([goodsDeailModel.goodsIsDiscount intValue] == 1) {
            goodPrice = [NSString stringWithFormat:@"%.2f",[goodsDeailModel.goodsPrice floatValue] * 0.75];
        }else {
            goodPrice = goodsDeailModel.goodsPrice;
        }
        nextVC.price = goodPrice;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


@end
