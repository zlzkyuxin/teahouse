//
//  CalculateAccountView.h
//  teahouse
//
//  Created by yuxin on 2017/5/11.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^isSelectBlock)();
typedef void(^calculateAccountBlock)();
@interface CalculateAccountView : UIView
@property (weak, nonatomic) IBOutlet UIButton *isSelectBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;

/** 选中点击回调*/
@property (strong, nonatomic) isSelectBlock block;
/** 结算点击回调*/
@property (strong, nonatomic) calculateAccountBlock calculateBlock;
@end
