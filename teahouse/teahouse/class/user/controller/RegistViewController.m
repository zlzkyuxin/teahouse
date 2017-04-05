//
//  RegistViewController.m
//  teahouse
//
//  Created by yuxin on 2017/2/23.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistTextField.h"
#import "HTTPViewController.h"
#define TIME 10

@interface RegistViewController ()
{
    NSTimer *timer;
    NSInteger time;
    UILabel *getCheck;
    UITapGestureRecognizer *tap;
}
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate distantFuture]];//关闭
    time = TIME;
}

- (void)initView {
    [super initView];
    
    WS(weakSelf)
    
    //用户名
    RegistTextField *userNick = [RegistTextField new];
    [self.view addSubview:userNick];
    [userNick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.top.equalTo(weakSelf.view).offset(150);
        make.height.mas_equalTo(@44);
    }];
    [userNick setPlaceholder:@"新账户(6-10个字符)" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
//    userNick.placeholder = @"新账户(6-10个字符)";
    
    //用户名底部分割线
    UILabel *userLine = [UILabel new];
    [self.view addSubview:userLine];
    [userLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.right.equalTo(userNick);
        make.top.equalTo(userNick.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    [userLine setBackgroundColor:[UIColor whiteColor]];
    
    //密码
    RegistTextField *password = [RegistTextField new];
    [self.view addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.right.equalTo(userNick);
        make.top.equalTo(userNick.mas_bottom).offset(10);
        make.height.equalTo(userNick);
    }];
    
    [password setPlaceholder:@"密码(请填写6-10位的密码)" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
//    password.placeholder = @"密码(请填写6-10位的密码)";
    
    //密码底部分割线
    UILabel *passLine = [UILabel new];
    [self.view addSubview:passLine];
    [passLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.right.equalTo(userNick);
        make.top.equalTo(password.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    [passLine setBackgroundColor:[UIColor whiteColor]];
    
    //手机号
    RegistTextField *phone = [RegistTextField new];
    [self.view addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.right.equalTo(userNick);
        make.top.equalTo(password.mas_bottom).offset(10);
        make.height.equalTo(userNick);
    }];
    [phone setPlaceholder:@"请输入11位手机号码" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
//    phone.placeholder = @"请输入11位手机号码";
    
    //手机号底部分割线
    UILabel *phoneLine = [UILabel new];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.right.equalTo(userNick);
        make.top.equalTo(phone.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    [phoneLine setBackgroundColor:[UIColor whiteColor]];
    
    
    //短信验证码
    RegistTextField *check = [RegistTextField new];
    [self.view addSubview:check];
    [check mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.right.equalTo(userNick.mas_right).offset(-100);
        make.top.equalTo(phone.mas_bottom).offset(10);
        make.height.equalTo(userNick);
    }];
    [check setPlaceholder:@"短信验证码" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
//    check.placeholder = @"短信验证码";
    
    //获取验证码
    getCheck = [UILabel new];
    [self.view addSubview:getCheck];
    [getCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(check);
        make.right.equalTo(userNick);
        make.width.mas_equalTo(@100);
        make.height.equalTo(check);
    }];
    [getCheck setText:@"获取验证码"];
    getCheck.textAlignment = NSTextAlignmentRight;
    getCheck.textColor = [UIColor greenColor];
    getCheck.font = [UIFont systemFontOfSize:15];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getChcekClick)];
    [getCheck addGestureRecognizer:tap];
    getCheck.userInteractionEnabled = YES;
    
    //短信验证码底部分割线
    UILabel *checkLine = [UILabel new];
    [self.view addSubview:checkLine];
    [checkLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.right.equalTo(userNick);
        make.top.equalTo(check.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    [checkLine setBackgroundColor:[UIColor whiteColor]];
    
    
    //
    UIImageView *argeeImage = [UIImageView new];
    [self.view addSubview:argeeImage];
    [argeeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNick);
        make.top.equalTo(check.mas_bottom).offset(20);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    argeeImage.image = [UIImage imageNamed:@"regist"];
    
    UILabel *argeeLabel = [UILabel new];
    [self.view addSubview:argeeLabel];
    [argeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(argeeImage.mas_right).offset(5);
        make.top.equalTo(argeeImage);
        make.height.equalTo(argeeImage);
    }];
    [argeeLabel setText:@"我已经看过并同意"];
    [argeeLabel setFont:[UIFont systemFontOfSize:14]];
    
    //服务协议
    UIButton *argeeBtn = [UIButton new];
    [self.view addSubview:argeeBtn];
    [argeeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(argeeLabel.mas_right);
        make.top.equalTo(argeeImage);
        make.height.equalTo(argeeImage);
        make.right.equalTo(weakSelf.view).offset(-20);
    }];
    [argeeBtn setTitle:@"《网络服务协议》" forState:UIControlStateNormal];
    [argeeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [argeeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [argeeBtn addTarget:self action:@selector(argeeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //注册
    UIButton *registBtn = [UIButton new];
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(25);
        make.right.equalTo(weakSelf.view).offset(-25);
        make.top.equalTo(argeeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(@35);
    }];
    [registBtn.layer setCornerRadius:5];
    [registBtn.layer setMasksToBounds:YES];
    [registBtn setBackgroundColor:[UIColor greenColor]];
    [registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
}

//定时器触发方法
- (void)getChcekClick {
    [getCheck removeGestureRecognizer:tap];
    getCheck.textColor = [UIColor lightGrayColor];
    getCheck.text = [NSString stringWithFormat:@"剩余%ds",TIME];
    [timer setFireDate:[NSDate distantPast]];//开启
}

//定时器方法
- (void)timerStart {
    time--;
    getCheck.text = [NSString stringWithFormat:@"剩余%lds",(long)time];
    if (time == 0) {
        [timer setFireDate:[NSDate distantFuture]];
        [getCheck setText:@"获取验证码"];
        getCheck.textColor = [UIColor greenColor];
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getChcekClick)];
        [getCheck addGestureRecognizer:tap];
        getCheck.userInteractionEnabled = YES;
        time = TIME;
    }
}

//服务协议
- (void)argeeBtnClick {
    [self presentViewController:[HTTPViewController new] animated:NO completion:nil];
}

//注册
- (void)regist {

}

- (void)dealloc {
    NSLog(@"注册页面被销毁");
}

@end
