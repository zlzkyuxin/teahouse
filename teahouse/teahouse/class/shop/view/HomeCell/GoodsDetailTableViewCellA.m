//
//  GoodsDetailTableViewCellA.m
//  teahouse
//
//  Created by zlzk on 2017/4/14.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "GoodsDetailTableViewCellA.h"

@implementation GoodsDetailTableViewCellA

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"GoodsDetailTableViewCellA";
    GoodsDetailTableViewCellA *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[GoodsDetailTableViewCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    //创建一个UIView比self.contentView小一圈
    CGRect frame = self.contentView.frame;
    UIView *bgView  = [[UIView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10)];
    bgView.backgroundColor = [UIColor whiteColor];
    //给bgView边框设置阴影
    bgView.layer.shadowOffset = CGSizeMake(1,1);
    bgView.layer.shadowOpacity = 0.3;
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:bgView];
    
    UILabel *topLine = [UILabel new];
    [bgView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(@0.5);
    }];
    [topLine setBackgroundColor:[UIColor lightGrayColor]];
    
//    self.contentView.backgroundColor = SETRGBColor(220, 220, 220);
    
    UILabel *bottomLine = [UILabel new];
    [bgView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@0.5);
    }];
    [bottomLine setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
