//
//  StoreViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "StoreViewController.h"
#import "ShopGoodMenuModel.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsDetailViewController.h"

#define TableViewWeidth   ([UIScreen mainScreen].bounds.size.width/4)

@interface StoreViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,

    UICollectionViewDelegate,
    UICollectionViewDataSource
>
{
    NSMutableArray *menuArray;
    
    UITableView *leftTableView;
    
    //左侧选中
    NSInteger leftSelectInteger;
}
@property (nonatomic , strong) UICollectionView *collectionView;
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self loadData];
    //初始化界面
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
}

//初始化数据
- (void)loadData {
    
    //默认选中第0行
    leftSelectInteger = 0;
    
    menuArray = @[].mutableCopy;
    
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"key":@"showGoodsMenu"}.copy;
//    [[TeaHouseNetWorking shareNetWorking] POST:@"shopgoods.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        TEALog(@"%@",result);
//        if ([result[@"code"] intValue] == 200) {
//            for (NSDictionary *dic in result[@"list"]) {
//                ShopGoodMenuModel *goodsMenu = [ShopGoodMenuModel mj_objectWithKeyValues:dic];
//                [menuArray addObject:goodsMenu];
//            }
//            TEALog(@"%@",menuArray);
//            [leftTableView reloadData];
//            //默认选中第一行
//            [leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
//            [_collectionView reloadData];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    
    [TeaHouseNetWorking POST:@"shopgoods.php" showHUD:YES  showMessage:@"商品加载中" parameters:loadDic success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            for (NSDictionary *dic in responseObject[@"list"]) {
                ShopGoodMenuModel *goodsMenu = [ShopGoodMenuModel mj_objectWithKeyValues:dic];
                [menuArray ARRAY_ADD_OBJ(goodsMenu)];
            }
            TEALog(@"%@",menuArray);
            [leftTableView reloadData];
            //默认选中第一行
            [leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            [_collectionView reloadData];
        }
    } failure:^(NSError *error) {
        [self createBackgroundImage:[UIImage imageNamed:@"failurelode"] title:@"" withResponseResult:TeaResponseError onView:self.view];
    }];
}

//初始化界面
- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TableViewWeidth, SCREEN_HEIGHT) style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.tableFooterView = [UIView new];
    [self.view addSubview:leftTableView];
    
    
    [self.view addSubview:self.collectionView];
    // 注册collectionViewcell:GoodsCollectionViewCell是我自定义的cell的类型
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectioncell"];
    //初始化布局类
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //collection的大小
    flowLayout.itemSize = CGSizeMake(110, 110);
    //间距
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 15, 0);
    [_collectionView setCollectionViewLayout:flowLayout];
}

//懒加载collection
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
         layout.minimumInteritemSpacing = 10;// 垂直方向的间距
         layout.minimumLineSpacing = 10; // 水平方向的间距
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(TableViewWeidth, 64, SCREEN_WIDTH - TableViewWeidth, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark - UITableViewDataSource代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuArray COUNT];
}

#pragma mark - UITableViewDelegate代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
    }
    ShopGoodMenuModel *goodsMenu = [menuArray ARRAY_OBJ_AT(indexPath.row)];
    cell.textLabel.text = goodsMenu.CategoryName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    TEALog(@"选中了%ld行",indexPath.row);
    leftSelectInteger = indexPath.row;
    [_collectionView reloadData];
}

#pragma mark -    UICollectionViewDataSource代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([menuArray COUNT] > 0) {
        ShopGoodMenuModel *goodsMenu = [menuArray ARRAY_OBJ_AT(leftSelectInteger)];
        NSArray *menuModelArray = goodsMenu.goodsMenu;
        return [menuModelArray COUNT];
    }
    return 0;
}

/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (menuArray.count > 0) {
        ShopGoodMenuModel *goodsMenu = [menuArray ARRAY_OBJ_AT(leftSelectInteger)];
        NSArray *menuModelArray = goodsMenu.goodsMenu;
        GoodsMenumModel *menuModel = [menuModelArray ARRAY_OBJ_AT(section)];
        NSArray *thirdModelArray = menuModel.thirdMenu;
        return [thirdModelArray COUNT];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    if ([menuArray COUNT] > 0) {
        ShopGoodMenuModel *goodsMenu = [menuArray ARRAY_OBJ_AT(leftSelectInteger)];
        NSArray *menuModelArray = goodsMenu.goodsMenu;
        GoodsMenumModel *menuModel = [menuModelArray ARRAY_OBJ_AT(indexPath.section)];
        NSArray *thirdModelArray = menuModel.thirdMenu;
        thirdMenuModel *thirdModel = [thirdModelArray ARRAY_OBJ_AT(indexPath.row)];
        //商品URL
        NSURL *goodsImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@thumbnail/%@.png",ImageURL,thirdModel.goodsImage]];
        [cell.goodsImage sd_setImageWithURL:goodsImageUrl];
        cell.textLabel.text = thirdModel.goodsThirdName;
    }
    return cell;
}

#pragma mark -    UICollectionViewDelegate代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TEALog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    if ([menuArray COUNT] > 0) {
        ShopGoodMenuModel *goodsMenu = [menuArray ARRAY_OBJ_AT(leftSelectInteger)];
        NSArray *menuModelArray = goodsMenu.goodsMenu;
        GoodsMenumModel *menuModel = [menuModelArray ARRAY_OBJ_AT(indexPath.section)];
        NSArray *thirdModelArray = menuModel.thirdMenu;
        thirdMenuModel *thirdModel = [thirdModelArray ARRAY_OBJ_AT(indexPath.row)];
        TEALog(@"选中商品的ID:%@",thirdModel.goodsthirdID);
        
        GoodsDetailViewController *nextVC = [[GoodsDetailViewController alloc] init];
        nextVC.goodsId = thirdModel.goodsthirdID;
        nextVC.title = thirdModel.goodsThirdName;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}























@end
