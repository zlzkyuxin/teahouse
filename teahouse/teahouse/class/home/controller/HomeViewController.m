//
//  HomeViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/23.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "HomeViewController.h"
#import "ScanViewController.h"
#import "NoticeViewController.h"
#import "SearchViewController.h"
#import "UIImageView+WebCache.h"
#import "YXButton.h"
#import "searchButton.h"
#import "TopView.h"
#import "LoopBanner.h"
#import "HotGoodsModel.h"
#import "HotGoodsTableViewCell.h"
#import "GoodsDetailViewController.h"
#import "PYSearch.h"
#import "CustomNavigationController.h"
#import "SearchResultModel.h"
#import <iflyMSC/iflyMSC.h>
#import "IATConfig.h"
#import "SearchResultModel.h"

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

#define NAV_FRAME (self.navigationController.navigationBar.frame.size)
#define STATUS_FRAME ([[UIApplication sharedApplication] statusBarFrame])
#define TOP_HEIGHT 64

@interface HomeViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UIScrollViewDelegate,
    TopViewDelegate,
    PYSearchViewControllerDelegate
>
{
    UITableView *homeTableView;
    
    TopView *topView;
    
    BOOL isChanged;
    
    NSMutableArray *dataArray;
    
    PYSearchViewController *searchViewVC;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self loadHomeData];
    //自定义navigationbar
    [self replaceNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/**
 加载页面
 */
- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    

    homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_TABBARHEIGHT - TOP_HEIGHT)];
//    if (@available(iOS 11.0 , *)) {
//
//        //解决ios11带来的新问题，没有导航栏，状态栏会在tableView滑动后消失引起的UI失配。
//        homeTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0 );
//
//    } else {
//
//        //iOS11以下，解决tableView偏移量下移20问题
//        self.automaticallyAdjustsScrollViewInsets = NO;
//
//    }
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:homeTableView];
    self.automaticallyAdjustsScrollViewInsets = false;//去掉顶部的留白
    
    
    LoopBanner *loop = [[LoopBanner alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (160.0/568.0) * SCREEN_HEIGHT) scrollDuration:5.f];
    loop.imageURLStrings = @[@"home1.jpg",@"home2.jpg",@"home3.jpg",@"home4.jpg"];
    loop.clickAction = ^(NSInteger index) {
        TEALog(@"点击了第%ld张图片",(long)index);
    };
    homeTableView.tableHeaderView = loop;
}

/**
 获取数据
 */
- (void)loadHomeData {
    dataArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary *loadDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [loadDic setValue:@"showHome" forKey:@"key"];
    
    [TeaHouseNetWorking POST:@"Home.php" showHUD:NO showMessage:@"" parameters:loadDic success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            NSDictionary *list = responseObject[@"list"];
            for (NSDictionary *dic in list[@"HotGoods"]) {
                HotGoodsModel *model = [HotGoodsModel mj_objectWithKeyValues:dic];
                [dataArray ARRAY_ADD_OBJ(model)];
            }
            [homeTableView reloadData];
        }
    } failure:^(NSError *error) {
        [self createBackgroundImage:[UIImage imageNamed:@"failurelode"] title:@"" withResponseResult:TeaResponseError onView:self.view];
    }];
    
}
#pragma mark 自定义头部视图
- (void)replaceNavigationBar {
    topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOP_HEIGHT)];
    [topView setBackgroundColor:[UIColor orangeColor]];
    topView.delegate = self;
    [self.view addSubview:topView];
}

#pragma mark topView的代理方法
- (void)scanBtnClick {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted) {
            TEALog(@"无法访问相册");
        }else if (status == PHAuthorizationStatusDenied) {
            TEALog(@"用户拒绝访问");
        }else if (status == PHAuthorizationStatusAuthorized) {
            TEALog(@"用户允许访问");
            [self presentViewController:[[ScanViewController alloc] init] animated:YES completion:nil];
        }else if (status ==PHAuthorizationStatusNotDetermined) {
            TEALog(@"用户没有选择");
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self presentViewController:[[ScanViewController alloc] init] animated:YES completion:nil];
                }
            }];
        }
    }
}

- (void)noticeBtnClick {
    [self.navigationController pushViewController:[[NoticeViewController alloc] init] animated:YES];
}

- (void)searchBtnClick {
    NSArray *arr = @[@"祁红香螺",@"阿萨姆红茶",@"汀布拉茶",@"桂花茶",@"菊花茶",@"金银花茶",@"柠檬茶",@"君山银针",@"白毫银针",@"大红袍",@"铁观音"].copy;
    WS(weakSelf)
    searchViewVC = [PYSearchViewController searchViewControllerWithHotSearches:arr searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"goodIsHave",@"goodName":searchText};
        //确认数据库存在该商品
        [TeaHouseNetWorking POST:@"shopgoods.php" showHUD:YES  showMessage:@"商品查询中" parameters:loadDic success:^(id responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                GoodsDetailViewController *nextVC = [GoodsDetailViewController new];
                nextVC.title = searchText;
                [weakSelf.navigationController pushViewController:nextVC animated:YES];
            } else {
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    
    //热门搜索风格
    searchViewVC.hotSearchStyle = PYHotSearchStyleDefault;
    //热门搜索历史搜索风格
    searchViewVC.searchHistoryStyle = PYSearchHistoryStyleDefault;
    searchViewVC.delegate = self;
    [searchViewVC.searchBar resignFirstResponder];
    CustomNavigationController *next = [[CustomNavigationController alloc] initWithRootViewController:searchViewVC];
    [self presentViewController:next animated:NO completion:nil];
}

- (void)voiceBtnClick {
    CustomNavigationController *next = [[CustomNavigationController alloc] initWithRootViewController:[SearchViewController new]];
    [self presentViewController:next animated:NO completion:nil];
}


#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"searchGoodName",@"goodStr":searchText};
        
        [TeaHouseNetWorking POST:@"shopgoods.php" showHUD:NO  showMessage:@"" parameters:loadDic success:^(id responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                NSMutableArray *resultArr = @[].mutableCopy;
                for (NSDictionary *dic in responseObject[@"list"]) {
                    SearchResultModel *model = [SearchResultModel mj_objectWithKeyValues:dic];
                    [resultArr ARRAY_ADD_OBJ(model.goodName)];
                }
                searchViewController.searchSuggestions = resultArr;
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
}

/**
 返回顶部
 */
- (void)backTop {
    [homeTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray COUNT];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotGoodsTableViewCell *cell = [HotGoodsTableViewCell cellWithTableView:tableView];
    cell.model = [dataArray ARRAY_OBJ_AT(indexPath.row)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotGoodsTableViewCell *cell = [HotGoodsTableViewCell cellWithTableView:tableView];
    cell.model = [dataArray ARRAY_OBJ_AT(indexPath.row)];
    return cell.cellHeight + 8 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailViewController *gdVC = [GoodsDetailViewController new];
    HotGoodsModel *model = [dataArray ARRAY_OBJ_AT(indexPath.row)];
    gdVC.title = model.goodsName;
    gdVC.goodsId = model.goodsID;
    [self.navigationController pushViewController:gdVC animated:YES];
}

#pragma mark UIScrollerView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    TEALog(@"%f",scrollView.contentOffset.y);
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alphaValue = offsetY / topView.frame.size.height;
    if (offsetY < 0) {//下拉隐藏自定义navigationbar
        topView.hidden = YES;
    }else {//上拉显示
        topView.hidden = NO;
        [self changeNavigationBar:NO];
        if (offsetY == 0) {
            [topView setBackgroundColor:[UIColor clearColor]];
        }else if (offsetY > 0 && offsetY < topView.frame.size.height) {
            [topView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:alphaValue]];
            
        }else {
            [topView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
            [self changeNavigationBar:YES];
        }
    }
    
}
#pragma mark 更改自定义navigationbar的样式
- (void)changeNavigationBar:(BOOL)change {
    if (change) {
        [topView.scanBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [topView.scanBtn setImage:[UIImage imageNamed:@"scan_black"] forState:(UIControlStateNormal)];
        
        [topView.noticeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [topView.noticeBtn setImage:[UIImage imageNamed:@"notice_black"] forState:(UIControlStateNormal)];
        
         [topView.voiceBtn setImage:[UIImage imageNamed:@"voice_gray"] forState:UIControlStateNormal];
        [topView.searchBtn setImage:[UIImage imageNamed:@"search_gray"] forState:UIControlStateNormal];
        [topView.searchBtn setTitleColor:SETRGBColor(180, 182, 189) forState:UIControlStateNormal];
    }else {
        [topView setBackgroundColor:[UIColor clearColor]];
        
        [topView.scanBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [topView.scanBtn setImage:[UIImage imageNamed:@"scan_white"] forState:(UIControlStateNormal)];
        
        [topView.noticeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [topView.noticeBtn setImage:[UIImage imageNamed:@"notice_white"] forState:(UIControlStateNormal)];
        [topView.voiceBtn setImage:[UIImage imageNamed:@"voice_white"] forState:UIControlStateNormal];
        [topView.searchBtn setImage:[UIImage imageNamed:@"search_white"] forState:UIControlStateNormal];
        [topView.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
@end
