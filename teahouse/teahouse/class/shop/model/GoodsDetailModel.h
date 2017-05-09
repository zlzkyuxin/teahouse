//
//  GoodsDetailModel.h
//  teahouse
//
//  Created by yuxin on 2017/2/22.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject
@property (nonatomic , strong)NSString *goodsID;
@property (nonatomic , strong)NSString *goodsName;
@property (nonatomic , strong)NSString *goodsIsDiscount;
@property (nonatomic , strong)NSString *goodsPrice;
@property (nonatomic , strong)NSString *goodsNumber;
@property (nonatomic , strong)NSString *goodsContent;
@property (nonatomic , strong)NSString *goodsImageName;
//@property (nonatomic , strong)NSArray *comment;
@end
