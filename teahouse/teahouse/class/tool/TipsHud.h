//
//  TipsHud.h
//  MallComponents
//
//  Created by holyjoy on 15/8/11.
//  Copyright (c) 2015年 holyjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsHud : UIView

+ (TipsHud *)sharedInstance;

- (void)showLoadingOnView:(UIView *)view;

- (void)showTips:(NSString *)str;

-(void)hideTips;

-(void)hideTips:(NSTimeInterval)delay;

@end
