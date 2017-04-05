//
//  LoginViewController.m
//  teahouse
//
//  Created by yuxin on 2017/1/4.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "LoginViewController.h"
#import "CustiomTabBarViewController.h"
#import "RegistViewController.h"
#import "RepasswordViewController.h"
#import "LoginModel.h"

@interface LoginViewController ()<MBProgressHUDDelegate>
{
    LoginModel *userInfo;
}
@property (nonatomic , strong)UITextField *userName;
@property (nonatomic , strong)UITextField *passWord;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [super addBackground];
    WS(weakSelf)
    //登录图标
    UIImageView *loginIcon = [UIImageView new];
    [self.view addSubview:loginIcon];
    [loginIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.view).offset(80);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
    }];
    loginIcon.layer.cornerRadius = 50;
    loginIcon.layer.masksToBounds = YES;
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    if (dic) {
        userInfo = [LoginModel mj_objectWithKeyValues:dic];
        NSString *iconImage = [NSString stringWithFormat:@"%@userImage/%@_original.png",ImageURL,userInfo.userImage];
        [loginIcon sd_setImageWithURL:[NSURL URLWithString:iconImage]];
    }else {
        loginIcon.image = [UIImage imageNamed:@"loginIcon"];
    }
    //用户图标
    UIImageView *userIcon = [UIImageView new];
    [self.view addSubview:userIcon];
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginIcon.mas_bottom).offset(40);
        make.left.equalTo(weakSelf.view).offset(30);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    userIcon.image = [UIImage imageNamed:@"userIcon"];
    //用户名
    UITextField *userName = [UITextField new];
    self.userName = userName;
    [self.view addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIcon.mas_right).offset(15);
        make.right.equalTo(weakSelf.view).offset(-40);
        make.top.equalTo(userIcon);
        make.height.equalTo(userIcon);
    }];
    userName.textColor = [UIColor whiteColor];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"请输入用户名或手机号码"];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, att.length)];
    userName.attributedPlaceholder = att;
    userName.font = [UIFont systemFontOfSize:14];
    
    userName.text = @"18119601479";
    
    //用户底部线条
    UIView *userLine = [UIView new];
    [self.view addSubview:userLine];
    [userLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIcon).offset(-5);
        make.right.equalTo(weakSelf.view).offset(-25);
        make.top.equalTo(userIcon.mas_bottom).offset(10);
        make.height.mas_equalTo(@1);
    }];
//    userLine.backgroundColor = SETRGBColor(155, 169, 161);
    userLine.backgroundColor = [UIColor whiteColor];
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
    self.passWord = passWord;
    [self.view addSubview:passWord];
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName);
        make.right.equalTo(userName);
        make.top.equalTo(passIcon);
        make.height.equalTo(userName);
    }];
    passWord.textColor = [UIColor whiteColor];
    NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc] initWithString:@"请设置6-16位密码"];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, att1.length)];
    passWord.attributedPlaceholder = att1;
    passWord.font = [UIFont systemFontOfSize:14];
    
    passWord.text = @"123456";
    
    //密码底部线条
    UIView *passLine = [UIView new];
    [self.view addSubview:passLine];
    [passLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userLine);
        make.right.equalTo(userLine);
        make.top.equalTo(passIcon.mas_bottom).offset(10);
        make.height.equalTo(userLine);
    }];
//    passLine.backgroundColor = SETRGBColor(155, 169, 161);
    passLine.backgroundColor = [UIColor whiteColor];
    //登录
    UIButton *doSubmit = [UIButton new];
    [self.view addSubview:doSubmit];
    [doSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passLine);
        make.right.equalTo(passLine);
        make.top.equalTo(passLine.mas_bottom).offset(40);
        make.height.mas_equalTo(@35);
    }];
    [doSubmit setTitle:@"登录" forState:UIControlStateNormal];
    [doSubmit setBackgroundColor:[UIColor whiteColor]];
    doSubmit.layer.cornerRadius = 15;
    doSubmit.layer.masksToBounds = YES;
    [doSubmit setTitleColor:SETRGBColor(94, 233, 231) forState:UIControlStateNormal];
    [doSubmit addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    //找回密码
    UIButton *rePassword = [UIButton new];
    [self.view addSubview:rePassword];
    [rePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(doSubmit.mas_bottom).offset(20);
        make.left.equalTo(doSubmit).offset(10);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@20);
    }];
    [rePassword.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [rePassword setTitle:@"找回密码?" forState:UIControlStateNormal];
    [rePassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rePassword addTarget:self action:@selector(rePassword) forControlEvents:UIControlEventTouchUpInside];
    //注册
    UIButton *regist = [UIButton new];
    [self.view addSubview:regist];
    [regist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(doSubmit).offset(-10);
        make.top.equalTo(rePassword);
        make.width.equalTo(rePassword);
        make.height.equalTo(rePassword);
    }];
    [regist setTitle:@"注册" forState:UIControlStateNormal];
    regist.titleLabel.textAlignment = NSTextAlignmentCenter;
    [regist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [regist.titleLabel setFont:[UIFont systemFontOfSize:12]];
    regist.layer.borderWidth = 1;
    regist.layer.cornerRadius = 10;
    regist.layer.masksToBounds = YES;
    regist.layer.borderColor = [UIColor whiteColor].CGColor;
    [regist addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    //底部三方登录
    UIView *leftLine = [UIView new];
    [self.view addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passLine);
        make.top.equalTo(rePassword.mas_bottom).offset(50);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@2);
    }];
    [leftLine setBackgroundColor:SETRGBColor(155, 169, 161)];
    
    UIView *rightLine = [UIView new];
    [self.view addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passLine);
        make.top.equalTo(leftLine);
        make.width.equalTo(leftLine);
        make.height.equalTo(leftLine);
    }];
    [rightLine setBackgroundColor:SETRGBColor(155, 169, 161)];
    
    UILabel *centerLabel = [UILabel new];
    [self.view addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLine.mas_right);
        make.right.equalTo(rightLine.mas_left);
        make.top.equalTo(rePassword.mas_bottom).offset(40);
        make.height.mas_equalTo(@22);
    }];
    centerLabel.text = @"合作账号登录";
    [centerLabel setTextColor:[UIColor whiteColor]];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.font = [UIFont systemFontOfSize:12];
}
//登录
- (void)login {
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    if (_userName != nil && _passWord != nil) {
        loadDic = @{@"key":@"login",@"userName":_userName.text,@"password":_passWord.text};
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.delegate = self;
    hud.alpha = 0.7;
    hud.label.text = @"正在登录中...";
    hud.label.font = [UIFont systemFontOfSize:12];
    [[TeaHouseNetWorking shareNetWorking] POST:@"login.php" parameters:loadDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"%@",result);
        if ([result[@"code"] intValue] == 200) {
            NSDictionary *list = result[@"list"];
            
            [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"list"];
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"islogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self presentViewController:[[CustiomTabBarViewController alloc] init] animated:NO completion:nil];
        }else if([result[@"code"] intValue] == 300){
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"密码错误";
            [hud hideAnimated:YES afterDelay:2];
        }else {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"登录失败";
            [hud hideAnimated:YES afterDelay:2];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络错误";
        [hud hideAnimated:YES afterDelay:2];
    }];
}
//注册
- (void)regist {
    [self presentViewController:[RegistViewController new] animated:YES completion:nil];
}
//找回密码
- (void)rePassword {
    [self presentViewController:[RepasswordViewController new] animated:YES completion:nil];
}


@end
