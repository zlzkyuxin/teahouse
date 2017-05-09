//
//  SearchViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/27.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "SearchViewController.h"
#import <iflyMSC/iflyMSC.h>
#import "IATConfig.h"
#import "SearchResultModel.h"
#import "PYSearch.h"
#import "GoodsDetailViewController.h"
#import "CustomNavigationController.h"

@interface SearchViewController ()
<
    IFlyRecognizerViewDelegate,
    PYSearchViewControllerDelegate
>
{
    PYSearchViewController *searchViewVC;
}
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hotSearches = @[@"祁红香螺",@"阿萨姆红茶",@"汀布拉茶",@"桂花茶",@"菊花茶",@"金银花茶",@"柠檬茶",@"君山银针",@"白毫银针",@"大红袍",@"铁观音"].copy;
        self.searchBar.placeholder = @"搜索";
    }
    return self;
}

//初始化界面
- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    WS(weakSelf)
    self.didSearchBlock = ^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"goodIsHave",@"goodName":searchText};
        //确认数据库存在该商品
        [[TeaHouseNetWorking shareNetWorking] POST:@"shopgoods.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            if ([result[@"code"] intValue] == 200) {
                GoodsDetailViewController *nextVC = [GoodsDetailViewController new];
                nextVC.title = searchText;
                [weakSelf.navigationController pushViewController:nextVC animated:YES];
            } else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
                hud.mode = MBProgressHUDModeIndeterminate;
                hud.label.text = @"无此商品信息,请重新查询";
                [hud hideAnimated:YES afterDelay:1.5];
                [hud removeFromSuperViewOnHide];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    };

    //热门搜索风格
    self.hotSearchStyle = PYHotSearchStyleRankTag;
    //热门搜索历史搜索风格
    self.searchHistoryStyle = PYSearchHistoryStyleDefault;
    self.delegate = self;
    
    //底部语音识别按钮
    UIButton *start = [UIButton new];
    [self.view addSubview:start];
    [start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@64);
        make.height.mas_equalTo(@64);
    }];
    [start setBackgroundColor:[UIColor greenColor]];
    [start setTitle:@"开始识别" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [start.titleLabel setFont:[UIFont systemFontOfSize:15]];
    start.tag = 1001;
    start.layer.cornerRadius = 32;
    start.layer.masksToBounds = YES;


}

- (void)btnClick {
    NSLog(@"%s[IN]",__func__);
    
    if(_iflyRecognizerView == nil)
    {
        [self initRecognizer];
    }
    //设置音频来源为麦克风
    [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iflyRecognizerView start];
    
}


- (void)initRecognizer {
    //单例模式，UI的实例
    if (_iflyRecognizerView == nil) {
        //UI显示剧中
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
    }
    _iflyRecognizerView.delegate = self;
    
    if (_iflyRecognizerView != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            //设置语言
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
    }
}

#pragma mark - IFlyRecognizerViewDelegate代理
/*!
 *  回调返回识别结果
 *
 *  @param resultArray 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度
 *  @param isLast      -[out] 是否最后一个结果
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast{
    if (!isLast) {
        
        NSString *key = [[[resultArray firstObject] allKeys] firstObject];
        NSLog(@"%@",key);
        
        self.searchBar.text = key;
        [self searchViewController:self searchTextDidChange:self.searchBar searchText:key];
        
    }
}

/*!
 *  识别结束回调
 *
 *  @param error 识别结束错误码
 */
- (void)onError: (IFlySpeechError *) error{

}


#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        
        NSDictionary *loadDic = [[NSDictionary alloc] init];
        loadDic = @{@"key":@"searchGoodName",@"goodStr":searchText};
        [[TeaHouseNetWorking shareNetWorking] POST:@"shopgoods.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            NSLog(@"%@",result);
            if ([result[@"code"] intValue] == 200) {
                NSMutableArray *resultArr = @[].mutableCopy;
                for (NSDictionary *dic in result[@"list"]) {
                    SearchResultModel *model = [SearchResultModel mj_objectWithKeyValues:dic];
                    [resultArr addObject:model.goodName];
                }
                if (resultArr.count > 0) {
                    searchViewController.searchSuggestions = resultArr;
                }else {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeIndeterminate;
                    hud.label.text = @"未查询到商品信息,请重新查询";
                    [hud hideAnimated:YES afterDelay:1.5];
                    [hud removeFromSuperViewOnHide];
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
}














@end

