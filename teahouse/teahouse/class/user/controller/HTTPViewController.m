//
//  HTTPViewController.m
//  teahouse
//
//  Created by zlzk on 2017/4/5.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "HTTPViewController.h"
#import <WebKit/WebKit.h>

@interface HTTPViewController ()
<
    WKUIDelegate,
    WKNavigationDelegate
>

@end

@implementation HTTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
   WKWebView *webView = [[WKWebView alloc]init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view);
    }];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HTTPAgreement]]];
    //返回
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 20, 20)];
    [back setImage:[UIImage imageNamed:@"cha1··.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)backLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
