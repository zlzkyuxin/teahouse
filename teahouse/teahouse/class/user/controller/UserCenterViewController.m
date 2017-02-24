//
//  UserCenterViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "LoginModel.h"
@interface UserCenterViewController ()
{
    LoginModel *userInfo;
}
@end

@implementation UserCenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏navigationbar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"islogin"] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"list"]) {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)loadData {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    NSLog(@"%@",dic);
    userInfo = [LoginModel mj_objectWithKeyValues:dic];
}

- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self logOut];
}
//登出
- (void)logOut {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"islogin"];
    [self presentViewController:[LoginViewController new] animated:YES completion:nil];
}

@end
