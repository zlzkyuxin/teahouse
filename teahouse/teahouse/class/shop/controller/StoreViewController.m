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

#define TableViewWeidth   100

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
    [[TeaHouseNetWorking shareNetWorking] POST:@"shopgoods.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"%@",result);
        if ([result[@"code"] intValue] == 200) {
            for (NSDictionary *dic in result[@"list"]) {
                ShopGoodMenuModel *goodsMenu = [ShopGoodMenuModel mj_objectWithKeyValues:dic];
                [menuArray addObject:goodsMenu];
            }
            NSLog(@"%@",menuArray);
            [leftTableView reloadData];
            //默认选中第一行
            [leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            [_collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
//    [self.collectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"collectioncell"];
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
    return menuArray.count;
}

#pragma mark - UITableViewDelegate代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
    }
    ShopGoodMenuModel *goodsMenu = menuArray[indexPath.row];
    cell.textLabel.text = goodsMenu.CategoryName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    NSLog(@"选中了%ld行",indexPath.row);
    leftSelectInteger = indexPath.row;
    [_collectionView reloadData];
}

#pragma mark -    UICollectionViewDataSource代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (menuArray.count > 0) {
        ShopGoodMenuModel *goodsMenu = menuArray[leftSelectInteger];
        NSArray *menuModelArray = goodsMenu.goodsMenu;
        return menuModelArray.count;
    }
    return 0;
}

/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (menuArray.count > 0) {
    ShopGoodMenuModel *goodsMenu = menuArray[leftSelectInteger];
    NSArray *menuModelArray = goodsMenu.goodsMenu;
    GoodsMenumModel *menuModel = menuModelArray[section];
    NSArray *thirdModelArray = menuModel.thirdMenu;
    return thirdModelArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    if (menuArray.count > 0) {
        ShopGoodMenuModel *goodsMenu = menuArray[leftSelectInteger];
        //    cell.textLabel.text = goodsMenu.CategoryName;
        NSArray *menuModelArray = goodsMenu.goodsMenu;
        GoodsMenumModel *menuModel = menuModelArray[indexPath.section];
        NSArray *thirdModelArray = menuModel.thirdMenu;
        thirdMenuModel *thirdModel = thirdModelArray[indexPath.row];
        //商品URL
        NSURL *goodsImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@thumbnail/%@.png",ImageURL,thirdModel.goodsImage]];
        [cell.goodsImage sd_setImageWithURL:goodsImageUrl];
        cell.textLabel.text = thirdModel.goodsThirdName;
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

#pragma mark -    UICollectionViewDelegate代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    if (menuArray.count > 0) {
        ShopGoodMenuModel *goodsMenu = menuArray[leftSelectInteger];
        NSArray *menuModelArray = goodsMenu.goodsMenu;
        GoodsMenumModel *menuModel = menuModelArray[indexPath.section];
        NSArray *thirdModelArray = menuModel.thirdMenu;
        thirdMenuModel *thirdModel = thirdModelArray[indexPath.row];
        NSLog(@"选中商品的ID:%@",thirdModel.goodsthirdID);
        GoodsDetailViewController *nextVC = [[GoodsDetailViewController alloc] init];
        nextVC.goodsId = thirdModel.goodsthirdID;
        nextVC.title = thirdModel.goodsThirdName;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}























@end
