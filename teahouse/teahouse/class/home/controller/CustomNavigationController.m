
//
//  CustomNavigationController.m
//  teahouse
//
//  Created by yuxin on 2016/12/28.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "CustomNavigationController.h"
#import "HomeViewController.h"
#import "StoreViewController.h"
#import "TeaViewController.h"
#import "UserCenterViewController.h"
@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    if ([viewController isKindOfClass:[HomeViewController class]] ||
        [viewController isKindOfClass:[StoreViewController class]] ||
        [viewController isKindOfClass:[TeaViewController class]] ||
        [viewController isKindOfClass:[UserCenterViewController class]]) {
        
    }else {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
        viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (self.viewControllers.count > 0) {
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [back setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
////        item.tintColor = [UIColor whiteColor];
//        viewController.navigationItem.leftBarButtonItem = item;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];

    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        viewController.navigationController.interactivePopGestureRecognizer.enabled = YES;
        viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
