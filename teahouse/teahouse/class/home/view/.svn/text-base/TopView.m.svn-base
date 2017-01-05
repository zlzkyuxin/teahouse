//
//  TopView.m
//  teahouse
//
//  Created by yuxin on 2016/12/27.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "TopView.h"
#import "YXButton.h"
#import "searchButton.h"

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setBtn];
    }
    return self;
}

- (void)initView {
    //左侧扫一扫
    YXButton *scanBtn = [[YXButton alloc] init];
    scanBtn.tag = 1000;
    [scanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _scanBtn = scanBtn;
    [self addSubview:scanBtn];
    //右侧消息
    YXButton *noticeBtn = [[YXButton alloc] init];
    noticeBtn.tag = 1001;
    [noticeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _noticeBtn = noticeBtn;
    [self addSubview:noticeBtn];
    
    UIView *searchView = [[UIView alloc] init];
    [searchView.layer setCornerRadius:4.0];
    [searchView.layer setMasksToBounds:YES];
    [searchView setBackgroundColor:SETRGBColor(232, 222, 223)];
    _searchView = searchView;
    [self addSubview:searchView];
    
    searchButton *searchBtn = [[searchButton alloc] init];
    searchBtn.tag = 1002;
    [searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn = searchBtn;
    [self addSubview:searchBtn];
    
    UIButton *voiceBtn = [[UIButton alloc] init];
    voiceBtn.tag = 1003;
    [voiceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _voiceBtn = voiceBtn;
    [self addSubview:voiceBtn];
    
    [searchView addSubview:searchBtn];
    [searchView addSubview:voiceBtn];
    
}

- (void)layoutSubviews {
    CGFloat _scanBtnX = 10;
    CGFloat _scanBtnY = 27;
    CGFloat _scanBtnW = 30;
    CGFloat _scanBtnH = 30;
    _scanBtn.frame = CGRectMake(_scanBtnX, _scanBtnY, _scanBtnW, _scanBtnH);
    
    CGFloat _noticeBtnX = SCREEN_WIDTH - 40;
    CGFloat _noticeBtnY = 27;
    CGFloat _noticeBtnW = 30;
    CGFloat _noticeBtnH = 30;
    _noticeBtn.frame = CGRectMake(_noticeBtnX, _noticeBtnY, _noticeBtnW, _noticeBtnH);
    
    CGFloat _searchViewX = CGRectGetMaxX(_scanBtn.frame) + 10;
    CGFloat _searchViewY = 25;
    CGFloat _searchViewW = SCREEN_WIDTH - 100;
    CGFloat _searchViewH = 30;
    _searchView.frame = CGRectMake(_searchViewX, _searchViewY, _searchViewW, _searchViewH);
    
    CGFloat _searchBtnX = 0;
    CGFloat _searchBtnY = 0;
    CGFloat _searchBtnW = _searchView.frame.size.width - 30;
    CGFloat _searchBtnH = 30;
    _searchBtn.frame = CGRectMake(_searchBtnX, _searchBtnY, _searchBtnW, _searchBtnH);
    
    CGFloat _voiceBtnX = CGRectGetMaxX(_searchBtn.frame) + 5;
    CGFloat _voiceBtnY = 5;
    CGFloat _voiceBtnW = 20;
    CGFloat _voiceBtnH = 20;
    _voiceBtn.frame = CGRectMake(_voiceBtnX, _voiceBtnY, _voiceBtnW, _voiceBtnH);
}

- (void)setBtn {
    [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_scanBtn setImage:[UIImage imageNamed:@"scan_white"] forState:UIControlStateNormal];
    [_scanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_noticeBtn setTitle:@"消息" forState:UIControlStateNormal];
    [_noticeBtn setImage:[UIImage imageNamed:@"notice_white"] forState:UIControlStateNormal];
    [_noticeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_voiceBtn setImage:[UIImage imageNamed:@"voice_white"] forState:UIControlStateNormal];
    
    [_searchBtn setImage:[UIImage imageNamed:@"search_white"] forState:UIControlStateNormal];
    _searchBtn.adjustsImageWhenHighlighted = NO;
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchBtn setTitle:@"wuli女神在哪里！" forState:UIControlStateNormal];
    
}

- (void)btnClick:(UIButton *)sender {
    if (sender.tag == 1000 && [self.delegate respondsToSelector:@selector(scanBtnClick)]) {
        [self.delegate scanBtnClick];
    }else if (sender.tag == 1001 && [self.delegate respondsToSelector:@selector(noticeBtnClick)]) {
        [self.delegate noticeBtnClick];
    }else if (sender.tag == 1002 && [self.delegate respondsToSelector:@selector(searchBtnClick)]) {
        [self.delegate searchBtnClick];
    }else if (sender.tag == 1003 && [self.delegate respondsToSelector:@selector(voiceBtnClick)]) {
        [self.delegate voiceBtnClick];
    }
}

@end
