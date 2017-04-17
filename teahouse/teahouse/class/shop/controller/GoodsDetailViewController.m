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
}
@property (nonatomic , strong) NSString *price;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"粟粟";
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
//        NSLog(@"点击了第%ld张图片",(long)index);
//    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    _tableView.tableHeaderView = topImage;
}

- (void)loadData {
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"key":@"goodsDetails",@"goodsID":self.goodsId};
    [[TeaHouseNetWorking shareNetWorking] POST:@"shopgoods.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
         NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"%@",result);
        if ([result[@"code"] intValue] == 200) {
            GoodsDetailModel *model = [GoodsDetailModel mj_objectWithKeyValues:[result[@"list"] firstObject]];
            self.price = model.goodsPrice;
            NSLog(@"%@",model);
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/original/%@.png",ImageURL,model.goodsImageName]];
            NSURL *url = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/wh%3D900%2C900/sign=e9ca6c55a0014c08196e20ac3a4b2e31/81cb39dbb6fd5266d0f8dde8a218972bd507367e.jpg" ];
//            NSURL *url = [NSURL URLWithString:@"http://10.37.26.26/TeaAPP/images/susu.jpg"];
            [topImage sd_setImageWithURL:url];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (indexPath.row == 0) {
        GoodsDetailTableViewCellB *cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailTableViewCellB" owner:self options:nil] firstObject];
        cell.block = ^() {
            NSLog(@"21312312");
        };
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
    return 64.f;
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
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"￥99.9"];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(1, att.length-1)];
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
    prices.adjustsFontSizeToFitWidth = YES;
    prices.text = @"门市价:￥199";
    prices.textColor = [UIColor lightGrayColor];
    
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
    NSLog(@"立即抢购");
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"islogin"]) {
        [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    }else {
        OrderListViewController *nextVC = [OrderListViewController new];
        nextVC.title = @"提交订单";
        nextVC.goodsName = self.title;
        nextVC.price = self.price;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//    footerView.backgroundColor = [UIColor greenColor];
//    return footerView;
//}


@end
