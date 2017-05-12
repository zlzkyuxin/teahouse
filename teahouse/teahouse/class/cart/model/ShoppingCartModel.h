//
//  ShoppingCartModel.h
//  teahouse
//
//  Created by yuxin on 2017/5/10.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject
/**   商品ID*/
@property (nonatomic , strong) NSString *goodsID;
/**   商品简介*/
@property (nonatomic , strong) NSString *goodsContent;
/**   商品图片名称*/
@property (nonatomic , strong) NSString *goodsImageName;
/**   商品名*/
@property (nonatomic , strong) NSString *goodsName;
/**   订单商品数量*/
@property (nonatomic , strong) NSString *goodsNumber;
/**   商品价格*/
@property (nonatomic , strong) NSString *goodsPrice;
/**   商品是否打折*/
@property (nonatomic , strong) NSString *goodsIsDiscount;
/**   订单ID*/
@property (nonatomic , strong) NSString *orderID;
/**   订单状态*/
@property (nonatomic , strong) NSString *orderState;
/**   订单时间*/
@property (nonatomic , strong) NSString *orderTime;
/**   订单总价*/
@property (nonatomic , strong) NSString *orderTotal;
/**   用户ID*/
@property (nonatomic , strong) NSString *userID;

@end
