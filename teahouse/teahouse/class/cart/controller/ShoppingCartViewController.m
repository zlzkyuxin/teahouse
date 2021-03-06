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
#import "CalculateAccountView.h"
#import "ShoppingCartModel.h"
#import "LoginModel.h"

@interface ShoppingCartViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
{
    LoginModel *userInfo;
    
    NSMutableArray *shopCartArray;
    
    UIButton *rightExitEdit;//退出编辑按钮
}
/**记录是否选中数组*/
@property (nonatomic , strong)NSMutableArray *selectArray;

/**记录结算工具条选中状态*/
@property (nonatomic , assign)BOOL accountIsSelect;

/**底部工具条*/
@property (nonatomic , strong)CalculateAccountView *bottomView;

/**选中数量*/
@property (nonatomic , assign)NSInteger selectNumber;

/**tabbleview*/
@property (nonatomic , strong) UITableView *tableView;

/**记录是否为编辑状态*/
@property (nonatomic , assign)BOOL isEditState;

/**记录退出编辑时商品数量*/
@property (nonatomic , assign)int exitEditGoodNumber;

/**记录处于编辑状态的indexPath*/
@property (nonatomic , strong)NSIndexPath *editIndexPath;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self loadData];
    //初始化界面
    [self initView];
    //集成刷新控件
    [self setupRefresh];
}

//初始化数据
- (void)loadData {
    //基础参数设置
    shopCartArray = @[].mutableCopy;
    //初始化记录是否选中数组
    _selectArray = @[].mutableCopy;
    self.accountIsSelect = YES;
    _isEditState = NO;//默认为非编辑状态
    
    //数据请求
    [self getData];
}

//数据请求
- (void)getData{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    if (dic != nil) {
        userInfo = [LoginModel mj_objectWithKeyValues:dic];
    }
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"key":@"orderFromUserID",@"userID":userInfo.userID,@"orderState":@"待付款"};
    
    [TeaHouseNetWorking POST:@"order.php" showHUD:YES  showMessage:@"订单查询中" parameters:loadDic success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            for (NSDictionary *dic in responseObject[@"list"]) {
                ShoppingCartModel *shopCartModel = [ShoppingCartModel mj_objectWithKeyValues:dic];
                [shopCartArray ARRAY_ADD_OBJ(shopCartModel)];
            }
            //记录是否选中数组赋值(默认全部未选中)
            for (int i = 0; i < [shopCartArray COUNT]; i++) {
                [_selectArray addObject:@"0"];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self createBackgroundImage:[UIImage imageNamed:@"failurelode"] title:@"" withResponseResult:TeaResponseError onView:self.view];
    }];

}

//初始化界面
- (void)initView {
    WS(weakSelf)
    //底部结算工具条
    _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"CalculateAccountView" owner:self options:nil] firstObject];
    if (_isOrderCommit) {//从订单提交页面跳转
        self.title = @"待付款";
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  - 44, SCREEN_WIDTH, 44);
    }else {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 49) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, - 40, 0);
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  - 44 - 49, SCREEN_WIDTH, 44);
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //设置行高
    _tableView.rowHeight = 80;
    
    //去掉底部多余分割线
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        //ios MJ刷新上下跳bug修复
        _tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset =UIEdgeInsetsMake(20,0,0,0);//64和49自己看效果，是否应该改成0
        _tableView.scrollIndicatorInsets =_tableView.contentInset;
    }
    
    _bottomView.block = ^() {
        if (weakSelf.accountIsSelect) {//选中状态
            [weakSelf.bottomView.isSelectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
            for (int i = 0; i < weakSelf.selectArray.count; i++) {
                if ([weakSelf.selectArray[i] isEqualToString:@"0"]) {
                    weakSelf.selectArray[i] = @"1";
                }
            }
            
            //设置结算数量和价格
            weakSelf.bottomView.totalLabel.text = [weakSelf CalculateAccount];
            [weakSelf.bottomView.accountBtn setTitle:[NSString stringWithFormat:@"结算(%lu)",(unsigned long)weakSelf.selectArray.count] forState:UIControlStateNormal];
            //刷新tableview
            [weakSelf.tableView reloadData];
            weakSelf.accountIsSelect = NO;
        }else {
            //设置未选中图片
            [weakSelf.bottomView.isSelectBtn setImage:[UIImage imageNamed:@"notSelected"] forState:UIControlStateNormal];
            for (int i = 0; i < weakSelf.selectArray.count; i++) {
                if ([weakSelf.selectArray[i] isEqualToString:@"1"]) {
                    weakSelf.selectArray[i] = @"0";
                }
            }
            //设置结算数量和价格
            weakSelf.bottomView.totalLabel.text = [weakSelf CalculateAccount];
            [weakSelf.bottomView.accountBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
            
            //刷新tableview
            [weakSelf.tableView reloadData];
            weakSelf.accountIsSelect = YES;
        }
    };
    
    _bottomView.calculateBlock = ^() {
        TEALog(@"%@",[weakSelf.bottomView.totalLabel.text substringWithRange:NSMakeRange(1, weakSelf.bottomView.totalLabel.text.length - 1)]);
    };
    [self.view addSubview:_bottomView];
    
    
}

//集成刷新控件
- (void)setupRefresh {
    WS(weakSelf)
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //使数据恢复到初始化状态
        [shopCartArray removeAllObjects];
        [weakSelf.selectArray removeAllObjects];
        weakSelf.isEditState = NO;
        //移除按钮
        [weakSelf removeRightExitEditFromSuperView];
        
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
        if (dic != nil) {
            userInfo = [LoginModel mj_objectWithKeyValues:dic];
        }
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"orderFromUserID",@"userID":userInfo.userID,@"orderState":@"待付款"};
        
        [TeaHouseNetWorking POST:@"order.php" showHUD:NO  showMessage:@"" parameters:loadDic success:^(id responseObject) {
            [weakSelf.tableView.mj_header endRefreshing];
            if ([responseObject[@"code"] intValue] == 200) {
                for (NSDictionary *dic in responseObject[@"list"]) {
                    ShoppingCartModel *shopCartModel = [ShoppingCartModel mj_objectWithKeyValues:dic];
                    [shopCartArray ARRAY_ADD_OBJ(shopCartModel)];
                }
                //刷新选中状态
                if (!weakSelf.accountIsSelect) {
                    [weakSelf.bottomView.isSelectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
                    for (int i = 0; i < [shopCartArray COUNT]; i++) {
                        [weakSelf.selectArray addObject:@"1"];
                    }
                }else {
                    [weakSelf.bottomView.isSelectBtn setImage:[UIImage imageNamed:@"notSelected"] forState:UIControlStateNormal];
                    for (int i = 0; i < [shopCartArray COUNT]; i++) {
                        [weakSelf.selectArray addObject:@"0"];
                    }
                }
                //刷新结算数据
                weakSelf.bottomView.totalLabel.text = [weakSelf CalculateAccount];
                [weakSelf.tableView reloadData];
            }
        } failure:^(NSError *error) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }];
}

#pragma mark - UITableViewDataSource代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [shopCartArray COUNT];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartTableViewCell"];
    WS(weakSelf)
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartTableViewCell" owner:self options:nil] firstObject];
    }
    //赋值
    cell.shopCartModel = [shopCartArray ARRAY_OBJ_AT(indexPath.section)];
    
    if (_isEditState && _editIndexPath == indexPath) {
        //当当前cell是编辑状态时不隐藏
        cell.editView.hidden = NO;
        if (_exitEditGoodNumber > 0) {//商品变化数量记录有值时,滚动界面时赋值
            cell.goodNumberTextField.text = [NSString stringWithFormat:@"%d",_exitEditGoodNumber];
        }
    }else {
        cell.editView.hidden = YES;
    }
    //取出记录按钮形态的值
    NSString *flag = [_selectArray ARRAY_OBJ_AT(indexPath.section)];
    //改变按钮形态
    if ([flag intValue] == 1) {//选中
        [cell.isSelectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else if ([flag intValue] == 0) {//未选中
        [cell.isSelectBtn setImage:[UIImage imageNamed:@"notSelected"] forState:UIControlStateNormal];
    }
    //点击回调
    cell.block = ^() {
        //点击后将记录是否选中按钮的数组中的记录置反
        weakSelf.selectArray[indexPath.section] = [NSString stringWithFormat:@"%d",![flag intValue]];
        //是否全部选中
        if ([weakSelf.selectArray containsObject:@"0"]) {
            weakSelf.accountIsSelect = YES;
            [weakSelf.bottomView.isSelectBtn setImage:[UIImage imageNamed:@"notSelected"] forState:UIControlStateNormal];
        }else {
            weakSelf.accountIsSelect = YES;
            [weakSelf.bottomView.isSelectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        }
        //结算数量
        weakSelf.selectNumber = 0;//默认为0
        //统计选中的数量
        for (NSString *str in weakSelf.selectArray) {
            if ([str intValue] == 1) {
                weakSelf.selectNumber += 1;
            }
        }
        //设置结算数量和价格
        weakSelf.bottomView.totalLabel.text = [self CalculateAccount];
        [weakSelf.bottomView.accountBtn setTitle:[NSString stringWithFormat:@"结算(%lu)",(unsigned long)weakSelf.selectNumber] forState:UIControlStateNormal];
        
        //刷新tableview
        [_tableView reloadData];
    };
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//设置头尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - UITableViewDelegate代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailViewController *nextVC = [GoodsDetailViewController new];
    ShoppingCartModel *model = [shopCartArray ARRAY_OBJ_AT(indexPath.section)];
    nextVC.goodsId = model.goodsID;
    nextVC.title = model.goodsName;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isEditState) {//非编辑状态下允许左划
        return YES;
    }else {
        return NO;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf)
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除cell及数据库数据
        [weakSelf deleteDataGoodsCell:indexPath];
    }];
    // 添加一个编辑按钮
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //编辑状态
        _isEditState = YES;
        //使cell恢复原状
        [_tableView reloadData];
        //编辑cell及更新数据库数据
        [weakSelf editDataGoodsCell:indexPath];
    }];
    editRowAction.backgroundColor = [UIColor blueColor];
    return @[deleteRowAction,editRowAction];
}


//删除cell
- (void)deleteDataGoodsCell:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定要删除这件商品吗？" preferredStyle:UIAlertControllerStyleAlert];
    //确认
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //移除按钮
        [self removeRightExitEditFromSuperView];
        //退出编辑状态
        _isEditState = NO;
        
        //点击确认删除之后删除本地并请求删除数据库
        ShoppingCartModel *model = [shopCartArray ARRAY_OBJ_AT(indexPath.section)];
        [shopCartArray removeObjectAtIndex:indexPath.section];//删除订单数据
        [_selectArray removeObjectAtIndex:indexPath.section];//删除选中记录
        //删除数据库
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"deleteOrder",@"orderID":model.orderID};
        
        
        [TeaHouseNetWorking POST:@"order.php" showHUD:YES  showMessage:@"正在删除" parameters:loadDic success:^(id responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                //刷新结算数据
                self.bottomView.totalLabel.text = [self CalculateAccount];
                [_tableView reloadData];//刷新界面
            }

        } failure:^(NSError *error) {
            
        }];
        
    }];
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //移除按钮
        [self removeRightExitEditFromSuperView];
        //退出编辑状态
        _isEditState = NO;
        //取消删除恢复原状
        [_tableView reloadData];
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//编辑cell
- (void)editDataGoodsCell:(NSIndexPath *)indexPath {
    _editIndexPath = indexPath;
    WS(weakSelf)
    ShoppingCartTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    cell.editView.hidden = NO;
    //数量变化回调
    cell.numberChangeBlock = ^(int number) {
        _exitEditGoodNumber = number;
    };
    //删除按钮点击回调
    cell.deleteBlock = ^() {
        [weakSelf deleteDataGoodsCell:indexPath];
    };
    //创建完成编辑按钮
    [self creatExitEditBtn];
}

//创建退出编辑按钮
- (void)creatExitEditBtn {
    rightExitEdit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightExitEdit setTitle:@"完成" forState:UIControlStateNormal];
    [rightExitEdit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightExitEdit.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightExitEdit addTarget:self action:@selector(rightExitEditClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightExitEdit];
}

//编辑退出事件
- (void)rightExitEditClick {
    //取出当前编辑位置的模型数据
    ShoppingCartModel *model = [shopCartArray ARRAY_OBJ_AT(_editIndexPath.section)];
    if (_exitEditGoodNumber > 0 && _exitEditGoodNumber != [model.goodsNumber intValue]) {//退出编辑时商品数量大于0或者与编辑前数量不相等

        //商品是否打折
        NSString *goodPrice = @"";
        if ([model.goodsIsDiscount intValue] == 1) {//打折
            goodPrice = [NSString stringWithFormat:@"%.2f",[model.goodsPrice floatValue] * 0.75];
        }else {
            goodPrice = model.goodsPrice;
        }
        //更新数据库
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"updateOrder",@"orderID":model.orderID,@"goodsNumber":[NSString stringWithFormat:@"%d",_exitEditGoodNumber],@"goodsPrice":goodPrice};
        [TeaHouseNetWorking POST:@"order.php" showHUD:YES  showMessage:@"数据更新中" parameters:loadDic success:^(id responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                //更新完数据库信息后改变界面数据模型
                model.goodsNumber = [NSString stringWithFormat:@"%d",_exitEditGoodNumber];
                //退出编辑状态
                _isEditState = NO;
                //商品数量编辑完成之后置空
                _exitEditGoodNumber = -1;
                //刷新当前行
                [_tableView reloadData];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    //完成事件移除按钮
    [self removeRightExitEditFromSuperView];
    //退出编辑状态
    _isEditState = NO;
    //将选中编辑的位置置空
    _editIndexPath = nil;
    //刷新当前行
    [_tableView reloadData];
}

//移除退出编辑按钮
- (void)removeRightExitEditFromSuperView {
    [rightExitEdit removeFromSuperview];
    rightExitEdit = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem new];
}

/**刷新某一个cell*/
- (void)reloadIndexPath:(NSIndexPath *)indexPath {
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:indexPath.section], nil] withRowAnimation:UITableViewRowAnimationFade];
}

/** 计算选中项的总价*/
- (NSString *)CalculateAccount {
    int total = 0;
    for (int i = 0; i < _selectArray.count; i++) {
        if ([_selectArray[i] intValue] == 1) {
            ShoppingCartModel *model = shopCartArray[i];
            total = total + [model.orderTotal intValue];
        }
    }
    return [NSString stringWithFormat:@"￥%.2f",(float)total];
}

@end
