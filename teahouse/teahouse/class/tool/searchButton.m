//
//  searchButton.m
//  teahouse
//
//  Created by yuxin on 2016/12/29.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "searchButton.h"

@implementation searchButton
- (instancetype)init {
    self = [super init];
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(5, 5, 20, 20);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = self.imageView.frame.size.width + 10;
    CGFloat titleW = contentRect.size.width - self.imageView.frame.size.width - 10;
    return CGRectMake(titleX, 5, titleW, 20);
}

@end
