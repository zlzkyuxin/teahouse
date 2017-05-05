
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
#import "ShoppingCartViewController.h"
#import "UserCenterViewController.h"
@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    if ([viewController isKindOfClass:[HomeViewController class]] ||
        [viewController isKindOfClass:[StoreViewController class]] ||
        [viewController isKindOfClass:[ShoppingCartViewController class]] ||
        [viewController isKindOfClass:[UserCenterViewController class]]) {
        
    }else {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (self.viewControllers.count > 0) {
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];

    }
    [super pushViewController:viewController animated:animated];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }

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
