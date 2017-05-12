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
/** 编辑状态下的商品内容*/
@property (weak, nonatomic) IBOutlet UILabel *goodEditContent;

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
    
    //编辑状态下商品简介
    self.goodEditContent.text = shopCartModel.goodsContent;
    
    //商品数量
    self.goodNumberLabel.text = [NSString stringWithFormat:@"x%@",shopCartModel.goodsNumber];
    
    //编辑状态下初始商品数量
    self.goodNumberTextField.text = [NSString stringWithFormat:@"%@",shopCartModel.goodsNumber];
    
    //商品是否打折
    if ([shopCartModel.goodsIsDiscount intValue] == 1) {//打折
        //商品原价
        self.originalPriceLabel.hidden = NO;
        
        NSDictionary *attribute = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",shopCartModel.goodsPrice] attributes:attribute];
        self.originalPriceLabel.attributedText = attributeStr;
        
        //商品折后价
        self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[shopCartModel.goodsPrice floatValue] * 0.75];
    }else {
        self.originalPriceLabel.hidden = YES;
        //商品折后价即是原价
        self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", shopCartModel.goodsPrice];
    }
    

    
}
//是否选中
- (IBAction)selectBtnClick:(UIButton *)sender {
    if (_block) {
        _block();
    }
}
//删除按钮点击事件
- (IBAction)deleteBtnClick:(UIButton *)sender {
    if (_deleteBlock) {
        _deleteBlock();
    }
}

//商品减少按钮点击事件
- (IBAction)subBtnClick:(UIButton *)sender {
    if ([_goodNumberTextField.text intValue] > 1) {
        _goodNumberTextField.text = [NSString stringWithFormat:@"%d",[_goodNumberTextField.text intValue] - 1];
    }
    NSLog(@"%@",_goodNumberTextField.text);
    if (_numberChangeBlock) {
        _numberChangeBlock([_goodNumberTextField.text intValue]);
    }
}

//商品添加按钮点击事件
- (IBAction)addBtnClick:(UIButton *)sender {
    if ([_goodNumberTextField.text intValue] > 0) {
        _goodNumberTextField.text = [NSString stringWithFormat:@"%d",[_goodNumberTextField.text intValue] + 1];
    }
    NSLog(@"%@",_goodNumberTextField.text);
    if (_numberChangeBlock) {
        _numberChangeBlock([_goodNumberTextField.text intValue]);
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_numberChangeBlock) {
        _numberChangeBlock([textField.text intValue]);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
