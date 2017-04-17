//
//  GoodsDetailTableViewCellB.m
//  teahouse
//
//  Created by zlzk on 2017/4/14.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "GoodsDetailTableViewCellB.h"

@implementation GoodsDetailTableViewCellB

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)leftBtnClcik:(UIButton *)sender {
    if (_block) {
        _block();
    }
}
- (IBAction)rightBtnClick:(UIButton *)sender {
    if (_block) {
        _block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
