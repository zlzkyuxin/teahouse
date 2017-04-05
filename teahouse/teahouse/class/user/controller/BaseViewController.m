//
//  BaseViewController.m
//  teahouse
//
//  Created by yuxin on 2017/2/23.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)addBackground {
//    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backImage.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:backImage];
}

- (void)initView {
    [self addBackground];
    //退出
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 20, 20)];
    [back setImage:[UIImage imageNamed:@"cha.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)backLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
