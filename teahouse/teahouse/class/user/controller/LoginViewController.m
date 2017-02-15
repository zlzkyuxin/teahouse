//
//  LoginViewController.m
//  teahouse
//
//  Created by yuxin on 2017/1/4.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic , strong)UITextField *userName;
@property (nonatomic , strong)UITextField *passWord;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [self.view setBackgroundColor:SETRGBColor(51, 203, 204)];
    
    WS(weakSelf)
    //登录图标
    UIImageView *loginIcon = [UIImageView new];
    [self.view addSubview:loginIcon];
    [loginIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.view).offset(100);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
    }];
    loginIcon.layer.cornerRadius = 50;
    loginIcon.layer.masksToBounds = YES;
    loginIcon.image = [UIImage imageNamed:@"loginIcon"];
    //用户图标
    UIImageView *userIcon = [UIImageView new];
    [self.view addSubview:userIcon];
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginIcon.mas_bottom).offset(40);
        make.left.equalTo(weakSelf).offset(30);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    userIcon.image = [UIImage imageNamed:@"userIcon"];
    //用户名
    UITextField *userName = [UITextField new];
    [self.view addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIcon.mas_right).offset(15);
        make.right.equalTo(weakSelf.view).offset(-40);
        make.top.equalTo(userIcon);
        make.height.equalTo(userIcon);
    }];
    userName.textColor = [UIColor whiteColor];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"请输入用户名或手机号码"];
    [att addAttribute:NSForegroundColorAttributeName value:SETRGBColor(94, 233, 231) range:NSMakeRange(0, att.length)];
    userName.attributedPlaceholder = att;
    userName.font = [UIFont systemFontOfSize:14];
    //用户底部线条
    UIView *userLine = [UIView new];
    [self.view addSubview:userLine];
    [userLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIcon).offset(-5);
        make.right.equalTo(weakSelf.view).offset(-25);
        make.top.equalTo(userIcon.mas_bottom).offset(10);
        make.height.mas_equalTo(@1);
    }];
    userLine.backgroundColor = SETRGBColor(94, 233, 231);
    //密码图标
    UIImageView *passIcon = [UIImageView new];
    [self.view addSubview:passIcon];
    [passIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIcon);
        make.width.equalTo(userIcon);
        make.height.equalTo(userIcon);
        make.top.equalTo(userIcon.mas_bottom).offset(40);
    }];
    passIcon.image = [UIImage imageNamed:@"password"];
    //密码
    UITextField *passWord = [UITextField new];
    [self.view addSubview:passWord];
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName);
        make.right.equalTo(userName);
        make.top.equalTo(passIcon);
        make.height.equalTo(userName);
    }];
    passWord.textColor = [UIColor whiteColor];
    NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc] initWithString:@"请设置6-16位密码"];
    [att1 addAttribute:NSForegroundColorAttributeName value:SETRGBColor(94, 233, 231) range:NSMakeRange(0, att1.length)];
    passWord.attributedPlaceholder = att1;
    passWord.font = [UIFont systemFontOfSize:14];
    //密码底部线条
    UIView *passLine = [UIView new];
    [self.view addSubview:passLine];
    [passLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userLine);
        make.right.equalTo(userLine);
        make.top.equalTo(passIcon.mas_bottom).offset(10);
        make.height.equalTo(userLine);
    }];
    passLine.backgroundColor = SETRGBColor(94, 233, 231);
    
    UIButton *doSubmit = [UIButton new];
    [self.view addSubview:doSubmit];
    
    
    UIButton *rePassword = [UIButton new];
    [self.view addSubview:rePassword];
    
    UIButton *regist = [UIButton new];
    [self.view addSubview:regist];
    
    
}

- (void)login {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *rootVC = self.presentingViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

@end
