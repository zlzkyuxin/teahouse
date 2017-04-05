//
//  TeaHouseNetWorking.h
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define ShopDetailsURL @"http://10.37.26.26/TeaAPP/images/category/"
#define ImageURL @"http://10.37.26.26/TeaAPP/images/"
#define HTTPAgreement @"http://10.37.26.26/TeaAPP/http.php"
@interface TeaHouseNetWorking : AFHTTPSessionManager
+ (instancetype)shareNetWorking;
@end
