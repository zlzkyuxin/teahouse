//
//  TeaBaseViewController.m
//  teahouse
//
//  Created by yuxin on 2017/5/18.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "TeaBaseViewController.h"


@interface TeaBaseViewController ()

@property (nonatomic , strong) UIView *backgroundView;

@end

@implementation TeaBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createBackgroundImage:(UIImage *)bgImage title:(NSString *)title withResponseResult:(TeaResponseResult)result onView:(UIView *)view{
    switch (result) {
        case TeaResponseNetError:
            if (!bgImage) {
                bgImage = [UIImage imageNamed:@""];
            }
            if (!title) {
                title = @"网络请求失败,请检查您的网络重新刷新试试！";
            }
            break;
        case TeaResponseNotData:
            if (!bgImage) {
                bgImage = [UIImage imageNamed:@""];
            }
            if (!title) {
                title = @"没有找到相关数据,请重新加载试试！";
            }
            break;
        case TeaResponseError:
            if (!bgImage) {
                bgImage = [UIImage imageNamed:@""];
            }
            if (!title) {
                title = @"数据错误,请重新加载试试";
            }
            break;
        default:
            break;
    }
    _backgroundView = [self createView:bgImage];
    if (view) {
        [view addSubview:_backgroundView];
    }else {
        [self.view addSubview:_backgroundView];
    }
    //[MBProgressHUD showMessage:title];
}

- (UIView *)createView:(UIImage *)image {
    UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundImage.image = image;
    [backgroundView addSubview:backgroundImage];
    return backgroundView;
}

- (void)dismissDefaultView {
    [_backgroundView removeFromSuperview];
    _backgroundView = nil;
}

@end
