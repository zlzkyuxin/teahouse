//
//  CalculateAccountView.m
//  teahouse
//
//  Created by yuxin on 2017/5/11.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "CalculateAccountView.h"

@implementation CalculateAccountView


- (IBAction)isSelectBtnClick:(id)sender {
    if (_block) {
        _block();
    }
}
- (IBAction)calculateAccountBtnClick:(UIButton *)sender {
    if (_calculateBlock) {
        _calculateBlock();
    }
}

@end
