//
//  TeaBaseViewController.h
//  teahouse
//
//  Created by yuxin on 2017/5/18.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TeaResponseSuccess = 0,//网络请求成功
    TeaResponseNetError,//无网络
    TeaResponseNotData,//无数据
    TeaResponseError//错误
}TeaResponseResult;

@interface TeaBaseViewController : UIViewController

- (void)createBackgroundImage:(UIImage *)bgImage title:(NSString *)title withResponseResult:(TeaResponseResult)result onView:(UIView *)view;

- (void)dismissDefaultView;

@end
