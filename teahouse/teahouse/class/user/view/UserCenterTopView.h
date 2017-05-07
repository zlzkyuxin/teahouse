//
//  UserCenterTopView.h
//  teahouse
//
//  Created by yuxin on 2017/5/6.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"

typedef void(^userIconBlock)();
@interface UserCenterTopView : UIView

@property (nonatomic , strong) LoginModel *userInfo;
@property (nonatomic , strong) UIImageView *userIconImage;
@property (nonatomic , strong) UILabel *userNameLabel;
@property (nonatomic , strong) userIconBlock block;

@end
