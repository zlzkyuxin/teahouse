
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
#import "UIImage+Addition.h"
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
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
//        back.mj_size = CGSizeMake(60, 60);
        [back setImage:[UIImage scaleToSize:[UIImage imageNamed:@"back"] size:CGSizeMake(30, 30)] forState:UIControlStateNormal];
//        [back setBackgroundImage:[UIImage scaleToSize:[UIImage imageNamed:@"back"] size:CGSizeMake(30, 30)] forState:UIControlStateNormal];
        
        //按钮内部所以内容左对齐
        back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [back addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
//        back.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
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


@end
