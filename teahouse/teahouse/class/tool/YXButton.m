//
//  YXButton.m
//  teahouse
//
//  Created by yuxin on 2016/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "YXButton.h"

@implementation YXButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont systemFontOfSize:8]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageH = contentRect.size.height * 2 / 3;
    CGFloat imageW = imageH;
    CGFloat imageX = (contentRect.size.width - imageW) / 2;
    return CGRectMake(imageX, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = contentRect.size.height * 2 / 3;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height / 3;
    return CGRectMake(0, titleY, titleW, titleH);
}

@end
