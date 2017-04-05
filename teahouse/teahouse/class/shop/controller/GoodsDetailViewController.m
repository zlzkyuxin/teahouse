//
//  GoodsDetailViewController.m
//  teahouse
//
//  Created by yuxin on 2017/2/22.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailModel.h"
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
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
            NSLog(@"%@",model);
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/original/%@.png",ImageURL,model.goodsImageName]];
            [topImage sd_setImageWithURL:url];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

@end
