//
//  CollectionInfoViewController.m
//  teahouse
//
//  Created by yuxin on 2017/5/17.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "CollectionInfoViewController.h"
#import "CollectionTableViewCell.h"
#import "GoodsDetailViewController.h"
#import "CollectionModel.h"

@interface CollectionInfoViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

/** 收藏商品模型数组*/
@property (nonatomic , strong) NSMutableArray *dataArray;

/** tableView*/
@property (nonatomic , strong) UITableView *tableView;
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
    //集成刷新
    [self setupRefresh];
}

//初始化数据
- (void)loadData {
    
    //初始化收藏商品的模型数组
    _dataArray = @[].mutableCopy;
    
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"key":@"selectCollection",@"userID":_userID};
    [TeaHouseNetWorking POST:@"collection.php" showHUD:NO showMessage:@"" parameters:loadDic success:^(id responseObject) {
        TEALog(@"---> %@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            for (NSDictionary *dic in responseObject[@"list"]) {
                CollectionModel *model = [CollectionModel mj_objectWithKeyValues:dic];
                [_dataArray ARRAY_ADD_OBJ(model)];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

//初始化界面
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的收藏";
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //设置行高
    if (iPhone5SE) {
        _tableView.rowHeight = 80;
    }else if (iPhone6_6s) {
        _tableView.rowHeight = 94;
    }else if (iPhone6Plus_6sPlus) {
        _tableView.rowHeight = 103.5;
    }
    //去掉底部多余分割线
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

//集成刷新
- (void)setupRefresh {
    WS(weakSelf)
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.dataArray removeAllObjects];
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"selectCollection",@"userID":_userID};
        [TeaHouseNetWorking POST:@"collection.php" showHUD:NO showMessage:@"" parameters:loadDic success:^(id responseObject) {
            TEALog(@"---> %@",responseObject);
            [weakSelf.tableView.mj_header endRefreshing];
            if ([responseObject[@"code"] intValue] == 200) {
                for (NSDictionary *dic in responseObject[@"list"]) {
                    CollectionModel *model = [CollectionModel mj_objectWithKeyValues:dic];
                    [weakSelf.dataArray ARRAY_ADD_OBJ(model)];
                }
                [weakSelf.tableView reloadData];
            }
        } failure:^(NSError *error) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }];
}

#pragma mark -UITableViewDataSource代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray COUNT];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionTableViewCell" owner:self options:nil] firstObject];
    }
    CollectionModel *model = [_dataArray ARRAY_OBJ_AT(indexPath.row)];
    cell.model = model;
    return cell;
}

#pragma mark -UITableViewDelegate代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionModel *model = [_dataArray ARRAY_OBJ_AT(indexPath.row)];
    GoodsDetailViewController *nextVC = [GoodsDetailViewController new];
    nextVC.goodsId = model.goodsID;
    nextVC.title = model.goodsName;
    [self.navigationController pushViewController:nextVC animated:YES];
}
#pragma mark - 编辑cell代理
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf)
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除按钮点击事件
        //添加提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定要取消收藏该商品吗？" preferredStyle:UIAlertControllerStyleAlert];
        //确认
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击确认删除之后删除本地并请求删除数据库
            CollectionModel *model = [weakSelf.dataArray ARRAY_OBJ_AT(indexPath.row)];
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];//删除本地数据
            //删除数据库
            NSDictionary *loadDic = [[NSDictionary alloc] init];
            loadDic = @{@"key":@"deleteCollection",@"collectionID":model.collectionID};
            [TeaHouseNetWorking POST:@"collection.php" showHUD:YES showMessage:@"正在删除中" parameters:loadDic success:^(id responseObject) {
                if ([responseObject[@"code"] intValue] == 200) {
                    [weakSelf.tableView reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }];
        //取消
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //取消删除恢复原状
            [_tableView reloadData];
        }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    return @[deleteRowAction];
}

@end
