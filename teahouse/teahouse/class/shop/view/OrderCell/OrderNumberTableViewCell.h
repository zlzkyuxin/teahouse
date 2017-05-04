//
//  OrderNumberTableViewCell.h
//  teahouse
//
//  Created by yuxin on 2017/4/15.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^numberBlock)(int number);

@interface OrderNumberTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *numberField;

@property (nonatomic , strong)numberBlock block;

@end
