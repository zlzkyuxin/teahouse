//
//  TopView.h
//  teahouse
//
//  Created by yuxin on 2016/12/27.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXButton;
@class searchButton;
@protocol TopViewDelegate <NSObject>

/**
 扫一扫按钮点击
 */
- (void)scanBtnClick;

/**
 消息按钮点击
 */
- (void)noticeBtnClick;
/**
 搜索条点击
 */
- (void)searchBtnClick;
/**
 语音搜索点击
 */
- (void)voiceBtnClick;

@end

@interface TopView : UIView

@property (nonatomic , strong)id<TopViewDelegate>delegate;

@property (nonatomic , strong)YXButton *scanBtn;
@property (nonatomic , strong)YXButton *noticeBtn;
@property (nonatomic , strong)UIView *searchView;
@property (nonatomic , strong)searchButton *searchBtn;
@property (nonatomic , strong)UIButton *voiceBtn;

@end
