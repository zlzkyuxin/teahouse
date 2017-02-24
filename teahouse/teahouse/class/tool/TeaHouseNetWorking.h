//
//  TeaHouseNetWorking.h
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define ShopDetailsURL @"http://192.168.1.119:8888/TeaAPP/images/original/"
#define ImageURL @"http://192.168.1.119:8888/TeaAPP/images/"
@interface TeaHouseNetWorking : AFHTTPSessionManager
+ (instancetype)shareNetWorking;
@end
