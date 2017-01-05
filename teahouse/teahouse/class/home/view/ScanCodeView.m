//
//  ScanCodeView.m
//  teahouse
//
//  Created by yuxin on 2016/12/30.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "ScanCodeView.h"
#import <AVFoundation/AVFoundation.h>
/*
 扫描内容的Y值
 */
#define scanContent_Y self.frame.size.height * 0.24
/*
 扫描内容的X值
 */
#define scanContent_X self.frame.size.width * 0.15
@interface ScanCodeView()
@property (nonatomic , strong)CALayer *basedLayer;
@property (nonatomic , strong)AVCaptureDevice *device;
//扫描线
@property (nonatomic , strong)UIImageView *animation_line;
@property (nonatomic , strong)NSTimer *timer;
@end

@implementation ScanCodeView

/*
 扫描动画线的高度
 */
static CGFloat const animation_line_H = 12;
/*
 扫描内容外部View的alpha值
 */
static CGFloat const scanBorderOutsideViewAlpha = 0.4;
/*
 定时器和动画的时间
 */
static CGFloat const timer_animation_Duration = 0.05;

- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer {
    self = [super initWithFrame:frame];
    if (self) {
        _basedLayer = outsideViewLayer;
        [self setScanBorder];
    }
    return self;
}

+ (instancetype)scanCodeViewWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer {
    return [[self alloc] initWithFrame:frame outsideViewLayer:outsideViewLayer];
}
/*
 创建扫描边框
 */
- (void)setScanBorder {
    UIView *scanContentView = [[UIView alloc] init];
    CGFloat scanContentViewX = scanContent_X;
    CGFloat scanContentViewY = scanContent_Y;
    CGFloat scanContentViewW = self.frame.size.width - 2 * scanContent_X;
    CGFloat scanContentViewH = scanContentViewW;
    scanContentView.frame = CGRectMake(scanContentViewX, scanContentViewY, scanContentViewW, scanContentViewH);
    scanContentView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6].CGColor;
    scanContentView.layer.borderWidth = 0.7;
    scanContentView.backgroundColor = [UIColor clearColor];
    [self.basedLayer addSublayer:scanContentView.layer];
    
    /*
     添加扫描动画
     */
    _animation_line = [[UIImageView alloc] init];
    _animation_line.image = [UIImage imageNamed:@"scanCodeLine"];
    _animation_line.frame = CGRectMake(scanContent_X * 0.5, scanContent_Y, self.frame.size.width - scanContent_X, animation_line_H);
    [self.basedLayer addSublayer:_animation_line.layer];
    
    /*
     添加定时器
     */
    _timer = [NSTimer scheduledTimerWithTimeInterval:timer_animation_Duration target:self selector:@selector(animtion_line_action) userInfo:nil repeats:YES];
    
    //上
    UIView *top_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, scanContentViewY)];
    top_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:top_View];
    //下
    UIView *botton_View = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scanContentView.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(scanContentView.frame))];
    botton_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:botton_View];
    //左
    UIView *left_View = [[UIView alloc] initWithFrame:CGRectMake(0, scanContentViewY, scanContent_X, scanContentViewH)];
    left_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:left_View];
    //右
    UIView *right_View = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scanContentView.frame), scanContentViewY, scanContent_X, scanContentViewH)];
    right_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:right_View];
    
    //提示信息
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.frame = CGRectMake(0, scanContent_X * 0.5, self.frame.size.width, 25);
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:13.0];
    promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    promptLabel.text = @"将二维码/条码放入框内,即可自动扫描";
    [botton_View addSubview:promptLabel];
    //灯光按钮
    UIButton *light_button = [[UIButton alloc] init];
    light_button.frame = CGRectMake(0, CGRectGetMaxY(promptLabel.frame) +scanContent_Y * 0.5, self.frame.size.width, 25);
    light_button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [light_button setTitle:@"开灯" forState:UIControlStateNormal];
    [light_button setTitle:@"关灯" forState:UIControlStateSelected];
    [light_button setTitleColor:promptLabel.textColor forState:UIControlStateNormal];
    [light_button addTarget:self action:@selector(light_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [botton_View addSubview:light_button];
    
#pragma mark 扫描区域四角图像
    //左上image
    CGFloat margin = 7;
    
    UIImage *left_image = [UIImage imageNamed:@"scanTopLeft"];
    UIImageView *left_imageView = [[UIImageView alloc] init];
    CGFloat left_imageViewX = CGRectGetMinX(scanContentView.frame) - left_image.size.width * 0.5 + margin;
    CGFloat left_imageViewY = CGRectGetMinY(scanContentView.frame) - left_image.size.width * 0.5 + margin;
    CGFloat left_imageViewW = left_image.size.width;
    CGFloat left_imageViewH = left_image.size.height;
    left_imageView.frame = CGRectMake(left_imageViewX, left_imageViewY, left_imageViewW, left_imageViewH);
    left_imageView.image = left_image;
    [_basedLayer addSublayer:left_imageView.layer];
    
    //右上image
    UIImage *right_image = [UIImage imageNamed:@"scanTopRight"];
    
    UIImageView *right_imageView = [[UIImageView alloc] init];
    CGFloat right_imageViewX = CGRectGetMaxX(scanContentView.frame) - right_image.size.width * 0.5 - margin;
    CGFloat right_imageViewY = left_imageView.frame.origin.y;
    CGFloat right_imageViewW = left_image.size.width;
    CGFloat right_imageViewH = left_image.size.height;
    right_imageView.frame = CGRectMake(right_imageViewX, right_imageViewY, right_imageViewW, right_imageViewH);
    right_imageView.image = right_image;
    [_basedLayer addSublayer:right_imageView.layer];
    
    //左下侧的image
    UIImage *left_bottom_image = [UIImage imageNamed:@"scanBottomLeft"];
    
    UIImageView *left_bottom_imageView = [[UIImageView alloc] init];
    CGFloat left_bottom_imageViewX = left_imageView.frame.origin.x;
    CGFloat left_bottom_imageViewY = CGRectGetMaxY(scanContentView.frame) - left_bottom_image.size.width * 0.5 - margin;
    CGFloat left_bottom_imageViewW = left_image.size.width;
    CGFloat left_bottom_imageViewH = left_image.size.height;
    left_bottom_imageView.frame = CGRectMake(left_bottom_imageViewX, left_bottom_imageViewY, left_bottom_imageViewW, left_bottom_imageViewH);
    left_bottom_imageView.image = left_bottom_image;
    [_basedLayer addSublayer:left_bottom_imageView.layer];
    
    //右下侧的image
    UIImage *right_bottom_image = [UIImage imageNamed:@"scanBottomRight"];
    
    UIImageView *right_bottom_imageView = [[UIImageView alloc] init];
    CGFloat right_bottom_imageViewX = right_imageView.frame.origin.x;
    CGFloat right_bottom_imageViewY = left_bottom_imageView.frame.origin.y;
    CGFloat right_bottom_imageViewW = left_image.size.width;
    CGFloat right_bottom_imageViewH = left_image.size.height;
    right_bottom_imageView.frame = CGRectMake(right_bottom_imageViewX, right_bottom_imageViewY, right_bottom_imageViewW, right_bottom_imageViewH);
    right_bottom_imageView.image = right_bottom_image;
    [_basedLayer addSublayer:right_bottom_imageView.layer];
    
}

#pragma mark 照明灯点击事件
- (void)light_buttonAction:(UIButton *)button {
    if (button.selected == NO) {//打开灯
        [self turnOnlifht:YES];
        button.selected = YES;
    }else {
        [self turnOnlifht:NO];
        button.selected = NO;
    }
}

- (void)turnOnlifht:(BOOL)open {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([_device hasFlash]) {
        [_device lockForConfiguration:nil];
        if (open) {
            [_device setTorchMode:AVCaptureTorchModeOn];
        }else {
            [_device setTorchMode:AVCaptureTorchModeOff];
        }
        [_device unlockForConfiguration];
    }
}

#pragma mark 定时器方法
- (void)animtion_line_action {
    __block CGRect frame = _animation_line.frame;
    static BOOL flag = YES;
    if (flag) {
        frame.origin.y = scanContent_Y;
        flag = NO;
        [UIView animateWithDuration:timer_animation_Duration animations:^{
            frame.origin.y += 5;
            _animation_line.frame = frame;
        } completion:nil];
    }else {
        if (_animation_line.frame.origin.y >= scanContent_Y) {
            CGFloat scanContent_MaxY = scanContent_Y + self.frame.size.width - 2 * scanContent_X;
            if (_animation_line.frame.origin.y >= scanContent_MaxY - 5) {
                frame.origin.y = scanContent_Y;
                _animation_line.frame = frame;
                flag = YES;
            }else {
                [UIView animateWithDuration:timer_animation_Duration animations:^{
                    frame.origin.y += 5;
                    _animation_line.frame = frame;
                } completion:nil];
            }
        }else {
            flag = !flag;
        }
    }
}

/*
 移除定时器
 */
- (void)removeTimer {
    [_timer invalidate];
    [_animation_line removeFromSuperview];
    _animation_line = nil;
}

@end
