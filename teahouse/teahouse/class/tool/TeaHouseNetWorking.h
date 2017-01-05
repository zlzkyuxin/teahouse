//
//  TeaHouseNetWorking.h
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface TeaHouseNetWorking : AFHTTPSessionManager
+ (instancetype)shareNetWorking;
@end
