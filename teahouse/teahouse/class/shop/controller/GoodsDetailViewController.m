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
#import "GoodsDetailHeader.h"
#import "LoginModel.h"

@interface GoodsDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    LoginModel *userInfo;
    UIImageView *topImage;
    GoodsDetailModel *goodsDeailModel;
}
/** 右上角收藏按钮*/
@property (nonatomic , strong) UIButton *collectionBtn;
/** 是否收藏*/
@property (nonatomic , assign) BOOL isCollection;
/** tableView*/
@property (nonatomic , strong) UITableView *tableView;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //查询该商品是否被收藏
    [self checkIsCollection];
    //初始化界面
    [self initView];
    //初始化数据
    [self loadData];
    //集成刷新控件
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

//初始化界面
- (void)initView {
//    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //顶部图片
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (160.0/568.0)*SCREEN_HEIGHT)];
    _tableView.tableHeaderView = topImage;
    
    //右上角收藏按钮
    _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
}

//数据请求
- (void)loadData {
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    if (!_goodsId) {
        loadDic = @{@"key":@"goodsSearch",@"goodName":self.title};
    }else {
        loadDic = @{@"key":@"goodsDetails",@"goodsID":self.goodsId};
    }
    
    [TeaHouseNetWorking POST:@"shopgoods.php" showHUD:NO  showMessage:@"商品查询中" parameters:loadDic success:^(id responseObject) {
        [_tableView.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue] == 200) {
            goodsDeailModel = [GoodsDetailModel mj_objectWithKeyValues:[responseObject[@"list"] firstObject]];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/original/%@.png",ImageURL,goodsDeailModel.goodsImageName]];
            [topImage sd_setImageWithURL:url];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [self createBackgroundImage:[UIImage imageNamed:@"failurelode"] title:@"" withResponseResult:TeaResponseError onView:self.view];
    }];
}

//集成刷新控件
- (void)setupRefresh {
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
    
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    // 设置普通状态的动画图片
    NSArray *idleImages = @[[UIImage imageNamed:@"icon_tab1_normal"],[UIImage imageNamed:@"icon_tab2_normal"],[UIImage imageNamed:@"icon_tab3_normal"]];
    [header setImages:idleImages forState:MJRefreshStateIdle];
    [header setTitle:@"新商品已就位" forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSArray *pullingImages = @[[UIImage imageNamed:@"icon_tab1_normal"],[UIImage imageNamed:@"icon_tab2_normal"],[UIImage imageNamed:@"icon_tab3_normal"]];
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    [header setTitle:@"你确定不看看新的商品？" forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    NSArray *refreshingImages = @[[UIImage imageNamed:@"icon_tab1_normal"],[UIImage imageNamed:@"icon_tab2_normal"],[UIImage imageNamed:@"icon_tab3_normal"]];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [header setTitle:@"新商品加载中" forState:MJRefreshStateRefreshing];
    // 设置 header
    self.tableView.mj_header = header;
}

//是否收藏
- (void)checkIsCollection {
    WS(weakSelf)
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    if (dic != nil) {
        userInfo = [LoginModel mj_objectWithKeyValues:dic];
    }
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"key":@"selectCollection",@"goodsID":_goodsId,@"userID":userInfo.userID};
    [TeaHouseNetWorking POST:@"collection.php" showHUD:NO showMessage:@"" parameters:loadDic success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            weakSelf.isCollection = YES;
            [self changeCollection:_isCollection];
        }else {
            weakSelf.isCollection = NO;
            [self changeCollection:_isCollection];
        }
    } failure:^(NSError *error) {
        _isCollection = NO;
        [self changeCollection:_isCollection];
    }];
}

#pragma mark - UITableViewDataSource代理
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

#pragma mark - tableView头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GoodsDetailHeader *headerView = [[GoodsDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    headerView.goodsDeailModel = goodsDeailModel;
    headerView.block = ^{
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

    };
    return headerView;
}

/** 收藏按钮点击事件*/
- (void)collectionBtnClick {
    WS(weakSelf)
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    if (dic != nil) {
        userInfo = [LoginModel mj_objectWithKeyValues:dic];
    }
    if (!_isCollection) {//添加收藏
        loadDic = @{@"key":@"addCollection",@"userID":userInfo.userID,@"goodsID":_goodsId};
    }else {//取消收藏
        loadDic = @{@"key":@"deleteCollection",@"userID":userInfo.userID,@"goodsID":_goodsId};
    }
    [TeaHouseNetWorking POST:@"collection.php" showHUD:YES showMessage:@"" parameters:loadDic success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            weakSelf.isCollection = !weakSelf.isCollection;
            [weakSelf changeCollection:weakSelf.isCollection];
        }
    } failure:^(NSError *error) {
        
    }];
}

//改变收藏按钮图片
- (void)changeCollection:(BOOL)isCollected {
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collectioned"] style:UIBarButtonItemStyleBordered target:self action:@selector(collectionBtnClick)];
    
    if (isCollected) {//收藏
        
        [_collectionBtn setImage:[UIImage scaleToSize:[UIImage imageNamed:@"collectioned"] size:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    }else {
        
        [_collectionBtn setImage:[UIImage scaleToSize:[UIImage imageNamed:@"notcollection"] size:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    }
    
    [_collectionBtn addTarget:self action:@selector(collectionBtnClick) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_collectionBtn];
}

@end
