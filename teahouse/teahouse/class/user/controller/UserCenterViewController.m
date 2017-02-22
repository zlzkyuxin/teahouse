//
//  UserCenterViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
@interface UserCenterViewController ()

@end

@implementation UserCenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏navigationbar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"islogin"] && ![[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]) {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

@end
