//
//  RegistTextField.m
//  teahouse
//
//  Created by zlzk on 2017/4/5.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "RegistTextField.h"

@implementation RegistTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

/** 更改提示字颜色和大小*/
- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font {
    [super setPlaceholder:placeholder];
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

@end
