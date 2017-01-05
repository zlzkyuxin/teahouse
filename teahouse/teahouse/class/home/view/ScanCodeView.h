//
//  ScanCodeView.h
//  teahouse
//
//  Created by yuxin on 2016/12/30.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanCodeView : UIView
- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer;
+ (instancetype)scanCodeViewWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer;
/*
 移除定时器
 */
- (void)removeTimer;
@end
