//
//  ShopGoodMenuModel.m
//  teahouse
//
//  Created by yuxin on 2017/5/9.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "ShopGoodMenuModel.h"

@implementation ShopGoodMenuModel

+ (NSDictionary *)objectClassInArray {
    
    return @{@"goodsMenu":@"GoodsMenumModel",};
}

@end

@implementation GoodsMenumModel

+ (NSDictionary *)objectClassInArray {
    
    return @{@"thirdMenu":@"thirdMenuModel",};
}


@end

@implementation thirdMenuModel

@end
