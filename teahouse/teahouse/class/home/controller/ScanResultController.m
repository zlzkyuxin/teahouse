//
//  ScanResultController.m
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "ScanResultController.h"
#import "HomeViewController.h"
@interface ScanResultController ()
{
    UIWebView *resultView;
}
@end

@implementation ScanResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    resultView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 68, 320, 500)];
    NSURLRequest *result = [NSURLRequest requestWithURL:[NSURL URLWithString:_resultURL]];
    [resultView loadRequest:result];
    [self.view addSubview:resultView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *rootVC = self.presentingViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
