//
//  GoodsDetailHeader.h
//  teahouse
//
//  Created by zlzk on 2017/5/19.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"

typedef void(^buyBtnClick)();

@interface GoodsDetailHeader : UIView

@property (nonatomic , strong) GoodsDetailModel *goodsDeailModel;
//点击代理
@property (nonatomic , strong) buyBtnClick block;

@end
