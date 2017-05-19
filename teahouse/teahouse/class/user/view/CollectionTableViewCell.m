//
//  CollectionTableViewCell.m
//  teahouse
//
//  Created by zlzk on 2017/5/19.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "CollectionTableViewCell.h"
@interface CollectionTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CollectionModel *)model {
    _model = model;
    //商品图片
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@original/%@.png",ImageURL,model.goodsImageName]];
    [self.goodImage sd_setImageWithURL:url];
    //商品名称
    self.titleLabel.text = model.goodsName;
    //商品简介
    self.contentLabel.text = model.goodsContent;
    //商品价格
    if ([model.goodsIsDiscount intValue]) {
        self.priceLabel.text = [NSString stringWithFormat:@"￥%2.f",[model.goodsPrice floatValue] * 0.75];
    }else {
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goodsPrice floatValue]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
