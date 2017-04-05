//
//  RegistTextField.h
//  teahouse
//
//  Created by zlzk on 2017/4/5.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistTextField : UITextField
/** 更改提示字颜色和大小*/
- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font;

@end
