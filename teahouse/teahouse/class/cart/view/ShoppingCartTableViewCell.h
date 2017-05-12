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
typedef void (^goodNumberChangeBlock)(int number);
typedef void (^deleteBtnBlock)();
@interface ShoppingCartTableViewCell : UITableViewCell

/** 是否选中*/
@property (weak, nonatomic) IBOutlet UIButton *isSelectBtn;
/** 编辑状态下view*/
@property (weak, nonatomic) IBOutlet UIView *editView;
/** 编辑状态下的商品数量*/
@property (weak, nonatomic) IBOutlet UITextField *goodNumberTextField;
/** 数据模型*/
@property (nonatomic , strong) ShoppingCartModel *shopCartModel;
/** 是否选中按钮点击回调*/
@property (nonatomic , strong) selectBtnBlock block;
/** 是否选中按钮点击回调*/
@property (nonatomic , strong) goodNumberChangeBlock numberChangeBlock;
/** 删除按钮点击回调*/
@property (nonatomic , strong) deleteBtnBlock deleteBlock;

@end
