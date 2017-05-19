//
//  GoodsDetailHeader.m
//  teahouse
//
//  Created by zlzk on 2017/5/19.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "GoodsDetailHeader.h"

@implementation GoodsDetailHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setGoodsDeailModel:(GoodsDetailModel *)goodsDeailModel {
    _goodsDeailModel = goodsDeailModel;
    WS(weakSelf)
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    //最新价格
    UILabel *price = [UILabel new];
    [self addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
    }];
    price.adjustsFontSizeToFitWidth = YES;
    
    NSString *goodsPrice = @"";
    if ([_goodsDeailModel.goodsIsDiscount intValue] == 0) {
        goodsPrice = [NSString stringWithFormat:@"￥%.1f",[_goodsDeailModel.goodsPrice floatValue]];
    }else {
        goodsPrice = [NSString stringWithFormat:@"￥%.2f",[_goodsDeailModel.goodsPrice floatValue] * 0.75];
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:goodsPrice];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(1, att.length-1)];
    price.attributedText = att;
    price.textColor = [UIColor greenColor];
    
    //
    UILabel *prices = [UILabel new];
    [self addSubview:prices];
    [prices mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(price.mas_right).offset(5);
        make.top.equalTo(price);
        make.bottom.equalTo(price);
    }];
    NSString *nowPrice = [NSString stringWithFormat:@"门市价:￥%.1f",[_goodsDeailModel.goodsPrice floatValue]];
    prices.adjustsFontSizeToFitWidth = YES;
    prices.text = nowPrice;
    prices.font = [UIFont systemFontOfSize:15];
    prices.textColor = [UIColor lightGrayColor];
    //是否隐藏原价
    if ([_goodsDeailModel.goodsIsDiscount intValue] == 0) {
        prices.hidden = YES;
    }else {
        prices.hidden = NO;
    }
    
    //立即抢购
    UIButton *buyBtn = [UIButton new];
    [self addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-15);
        make.top.equalTo(weakSelf).offset(15);
        make.bottom.equalTo(weakSelf).offset(-15);
    }];
    [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:[[UIColor orangeColor] colorWithAlphaComponent:1]];
    [buyBtn.layer setCornerRadius:3];
    [buyBtn.layer setMasksToBounds:YES];
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //
    UILabel *line = [UILabel new];
    [weakSelf addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.height.mas_offset(@0.5);
    }];
    [line setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)buyBtnClick {
    if (_block) {
        _block();
    }
}
@end
