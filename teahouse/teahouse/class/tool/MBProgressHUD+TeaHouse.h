//
//  MBProgressHUD+TeaHouse.h
//  teahouse
//
//  Created by yuxin on 2017/5/11.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (TeaHouse)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
/**  显示信息*/
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
/**  隐藏*/
+ (void)hideHUD;

@end
