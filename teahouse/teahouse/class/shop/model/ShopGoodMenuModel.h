//
//  ShopGoodMenuModel.h
//  teahouse
//
//  Created by yuxin on 2017/5/9.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsMenumModel;
@class thirdMenuModel;

@interface ShopGoodMenuModel : NSObject

@property (nonatomic , strong) NSString *CategoryID;
@property (nonatomic , strong) NSString *CategoryName;
@property (nonatomic , strong) NSArray *goodsMenu;

@end

@interface GoodsMenumModel : NSObject

@property (nonatomic , strong) NSString *goodsID;
@property (nonatomic , strong) NSString *goodsName;
@property (nonatomic , strong) NSArray *thirdMenu;

@end

@interface thirdMenuModel : NSObject

@property (nonatomic , strong) NSString *goodsthirdID;
@property (nonatomic , strong) NSString *goodsThirdName;
@property (nonatomic , strong) NSString *goodsImage;

@end
