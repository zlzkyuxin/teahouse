//
//  ShoppingCartTableViewCell.m
//  teahouse
//
//  Created by zlzk on 2017/5/10.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
@interface ShoppingCartTableViewCell ()

/** 商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
/** 商品名*/
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
/** 商品内容简介*/
@property (weak, nonatomic) IBOutlet UILabel *goodContentLabel;
/** 商品折后价*/
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
/** 商品原价*/
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
/** 商品数量*/
@property (weak, nonatomic) IBOutlet UILabel *goodNumberLabel;

@end

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShopCartModel:(ShoppingCartModel *)shopCartModel {
    _shopCartModel = shopCartModel;
    
    //商品图片
    NSURL *goodImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@original/%@.png",ImageURL,shopCartModel.goodsImageName]];
    [self.goodImage sd_setImageWithURL:goodImageUrl];
    
    //商品名称
    self.goodNameLabel.text = shopCartModel.goodsName;
    
    //商品简介
    self.goodContentLabel.text = shopCartModel.goodsContent;
    
    //商品数量
    self.goodNumberLabel.text = shopCartModel.goodsNumber;
    
    //订单单价 = 订单总价/订单数量
    NSString *goodPrice = [NSString stringWithFormat:@"%.2f", [shopCartModel.orderTotal floatValue] / [shopCartModel.goodsNumber floatValue]];
    if ([shopCartModel.goodsPrice floatValue] - [goodPrice floatValue] < 1) {
        self.originalPriceLabel.hidden = YES;
        //商品折后价
        self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", shopCartModel.goodsPrice];
    }else {
        //商品原价
        self.originalPriceLabel.hidden = NO;
        self.originalPriceLabel.text = [NSString stringWithFormat:@"￥%@",shopCartModel.goodsPrice];
        //商品折后价
        self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@",goodPrice];
    }
    

    
}
- (IBAction)selectBtnClick:(UIButton *)sender {
    if (_block) {
        _block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
