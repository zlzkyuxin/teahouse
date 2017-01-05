//
//  HotGoodsModel.h
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotGoodsModel : NSObject
@property (nonatomic , strong)NSString *goodsID;//商品ID
@property (nonatomic , strong)NSString *goodsName;//商品名
@property (nonatomic , strong)NSString *content;//商品简介
@property (nonatomic , strong)NSString *beforePrice;//商品原价
@property (nonatomic , strong)NSString *nowPrice;//商品现价
@property (nonatomic , strong)NSString *detailsImageName;//图片
@property (nonatomic , strong)NSString *categoryName;//所属类别
@end
