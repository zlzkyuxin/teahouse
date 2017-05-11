//
//  ShoppingCartTableViewCell.h
//  teahouse
//
//  Created by zlzk on 2017/5/10.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
typedef void (^selectBtnBlock)();
@interface ShoppingCartTableViewCell : UITableViewCell

/** 是否选中*/
@property (weak, nonatomic) IBOutlet UIButton *isSelectBtn;
/** 数据模型*/
@property (nonatomic , strong) ShoppingCartModel *shopCartModel;
/** 是否选中按钮点击回调*/
@property (nonatomic , strong) selectBtnBlock block;

@end
