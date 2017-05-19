//
//  CollectionModel.h
//  teahouse
//
//  Created by zlzk on 2017/5/19.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

/** 收藏商品ID*/
@property (nonatomic , strong) NSString *collectionID;
/** 收藏的商品ID*/
@property (nonatomic , strong) NSString *goodsID;
/** 收藏的商品名称*/
@property (nonatomic , strong) NSString *goodsName;
/** 收藏的商品价格*/
@property (nonatomic , strong) NSString *goodsPrice;
/** 收藏的商品是否打折*/
@property (nonatomic , strong) NSString *goodsIsDiscount;
/** 收藏的商品的简介*/
@property (nonatomic , strong) NSString *goodsContent;
/** 收藏的商品图片*/
@property (nonatomic , strong) NSString *goodsImageName;

@end
