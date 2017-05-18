//
//  UserCenterTopView.h
//  teahouse
//
//  Created by yuxin on 2017/5/6.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"

typedef void(^userIconBlock)(NSInteger tag);

@interface UserCenterTopView : UIView
/**  用户信息模型 */
@property (nonatomic , strong) LoginModel *userInfo;
/**  用户头像 */
@property (nonatomic , strong) UIButton *userIconImage;
/**  用户昵称 */
@property (nonatomic , strong) UILabel *userNameLabel;

@property (nonatomic , strong) userIconBlock block;

@end
