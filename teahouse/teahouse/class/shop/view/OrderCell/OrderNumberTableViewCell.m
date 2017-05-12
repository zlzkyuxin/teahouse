//
//  OrderNumberTableViewCell.m
//  teahouse
//
//  Created by yuxin on 2017/4/15.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "OrderNumberTableViewCell.h"
@interface OrderNumberTableViewCell()
<
    UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@end

@implementation OrderNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _numberField.delegate = self;
}
- (IBAction)subBtnClick:(UIButton *)sender {
    if ([_numberField.text intValue] > 1) {
        _numberField.text = [NSString stringWithFormat:@"%d",[_numberField.text intValue] - 1];
    }
    TEALog(@"%@",_numberField.text);
    if (_block) {
        _block([_numberField.text intValue]);
    }
}
- (IBAction)addBtnClick:(UIButton *)sender {
    if ([_numberField.text intValue] > 0) {
        _numberField.text = [NSString stringWithFormat:@"%d",[_numberField.text intValue] + 1];
    }
    TEALog(@"%@",_numberField.text);
    if (_block) {
        _block([_numberField.text intValue]);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_block) {
        _block([_numberField.text intValue]);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
