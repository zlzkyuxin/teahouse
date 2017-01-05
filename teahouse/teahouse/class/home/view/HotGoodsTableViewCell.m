//
//  HotGoodsTableViewCell.m
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "HotGoodsTableViewCell.h"
#import "HotGoodsModel.h"
#import "UIImageView+WebCache.h"

@interface HotGoodsTableViewCell ()
@property (nonatomic , strong)UIImageView *goodsIamge;//商品图片
@property (nonatomic , strong)UILabel *categoryLabel;//商品类别
@property (nonatomic , strong)UILabel *contentLabel;//商品简介
@property (nonatomic , strong)UILabel *goodsNameLabel;//商品名
@property (nonatomic , strong)UILabel *nowPriceLabel;//商品现价
@property (nonatomic , strong)UILabel *beforePriceLabel;//商品原价


@end

@implementation HotGoodsTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"HotGoodsTableViewCell";
    HotGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HotGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    //设置cell不能点击
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //图片
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    _goodsIamge = goodsImageView;
    [self.contentView addSubview:goodsImageView];
    //类别标签
    UILabel *categoryLabel = [[UILabel alloc] init];
    _categoryLabel = categoryLabel;
    [self.contentView addSubview:categoryLabel];
    //简介
    UILabel *contentLabel = [[UILabel alloc] init];
    _contentLabel = contentLabel;
    [self.contentView addSubview:contentLabel];
    //商品名
    UILabel *goodsNameLabel = [[UILabel alloc] init];
    _goodsNameLabel = goodsNameLabel;
    [self.contentView addSubview:goodsNameLabel];
    //商品现价
    UILabel *nowPriceLabel = [[UILabel alloc] init];
    _nowPriceLabel = nowPriceLabel;
    [self.contentView addSubview:nowPriceLabel];
    //商品原价
    UILabel *beforePriceLabel = [[UILabel alloc] init];
    _beforePriceLabel = beforePriceLabel;
    [self.contentView addSubview:beforePriceLabel];
    
}

- (void)layoutSubviewsss {
    CGFloat padding = 8;
    //图片
    CGFloat goodsImageX = 0;
    CGFloat goodsImageY = 0;
    CGFloat goodsImageW = SCREEN_WIDTH;
    CGFloat goodsImageH = SCREEN_HEIGHT / 3.5;
    _goodsIamge.frame = CGRectMake(goodsImageX, goodsImageY, goodsImageW, goodsImageH);
    //类别
    CGSize categorySize = [_model.categoryName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    CGFloat categoryX = 20;
    CGFloat categoryY = padding;
    CGFloat categoryW = categorySize.width;
    CGFloat categoryH = categorySize.height;
    _categoryLabel.frame = CGRectMake(categoryX, categoryY, categoryW, categoryH);
    //简介
    CGSize contentSize = [_model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CGFloat contentX = padding;
    CGFloat contentY = CGRectGetMaxY(_goodsIamge.frame) + padding;
    CGFloat contentW = contentSize.width;
    CGFloat contentH = contentSize.height;
    _contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
    //商品名
    CGSize goodsNameSize = [_model.goodsName boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    CGFloat goodsNameX = padding;
    CGFloat goodsNameY = CGRectGetMaxY(_contentLabel.frame) + padding;
    CGFloat goodsNameW = goodsNameSize.width;
    CGFloat goodsNameH = goodsNameSize.height;
    _goodsNameLabel.frame = CGRectMake(goodsNameX, goodsNameY, goodsNameW, goodsNameH);
    //价格
    if (_model.nowPrice) {//存在打折
        //商品现价
        CGSize nowPriceSize = [_model.nowPrice boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGFloat nowPriceX = padding;
        CGFloat nowPriceY = CGRectGetMaxY(_goodsNameLabel.frame) + 2 * padding;
        CGFloat nowPriceW = nowPriceSize.width;
        CGFloat nowPriceH = nowPriceSize.height;
        _nowPriceLabel.frame = CGRectMake(nowPriceX, nowPriceY, nowPriceW, nowPriceH);
        //商品原价
        CGSize beforePriceSize = [_model.beforePrice boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGFloat beforePriceX = CGRectGetMaxX(_nowPriceLabel.frame) + padding;
        CGFloat beforePriceY = _nowPriceLabel.frame.origin.y;
        CGFloat beforePriceW = beforePriceSize.width;
        CGFloat beforePriceH = beforePriceSize.height;
        _beforePriceLabel.frame = CGRectMake(beforePriceX, beforePriceY, beforePriceW, beforePriceH);
    }else {//不存在
        //商品只有一个价格
        CGSize beforePriceSize = [_model.beforePrice boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGFloat beforePriceX = padding;
        CGFloat beforePriceY = CGRectGetMaxY(_goodsNameLabel.frame) + 2 * padding;
        CGFloat beforePriceW = beforePriceSize.width;
        CGFloat beforePriceH = beforePriceSize.height;
        _beforePriceLabel.frame = CGRectMake(beforePriceX, beforePriceY, beforePriceW, beforePriceH);
    }
    
    
}

- (void)setModel:(HotGoodsModel *)model {
    _model = model;
    [self layoutSubviewsss];
    //图片
    [_goodsIamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",ShopDetailsURL,_model.detailsImageName ]]];
    //类别
    _categoryLabel.text = _model.categoryName;
    [_categoryLabel setFont:[UIFont systemFontOfSize:11]];
    [_categoryLabel setTextColor:[UIColor whiteColor]];
    [_categoryLabel setBackgroundColor:[UIColor lightGrayColor]];
    //简介
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = _model.content;
    [_contentLabel setFont:[UIFont systemFontOfSize:14]];
    //商品名
    _goodsNameLabel.text = _model.goodsName;
    [_goodsNameLabel setFont:[UIFont systemFontOfSize:12]];
    [_goodsNameLabel setTextColor:[UIColor grayColor]];
    //商品现价
    if (_model.nowPrice) {
        _nowPriceLabel.hidden = NO;
        _nowPriceLabel.text = _model.nowPrice; //划线
        [_nowPriceLabel setFont:[UIFont systemFontOfSize:15]];
        [_nowPriceLabel setTextColor:[UIColor redColor]];
        NSDictionary *attribiDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribStr = [[NSMutableAttributedString alloc] initWithString:_model.beforePrice attributes:attribiDic];
        _beforePriceLabel.attributedText = attribStr;
        [_beforePriceLabel setFont:[UIFont systemFontOfSize:15]];
    }else {
        _nowPriceLabel.hidden = YES;
        _beforePriceLabel.text = _model.beforePrice;
        [_beforePriceLabel setFont:[UIFont systemFontOfSize:15]];
    }
    _cellHeight = CGRectGetMaxY(_beforePriceLabel.frame);
}

@end
