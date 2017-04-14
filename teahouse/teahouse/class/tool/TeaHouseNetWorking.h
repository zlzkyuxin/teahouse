//
//  TeaHouseNetWorking.h
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#define TEST

#ifdef TEST

#define BaseUrl @"http://192.168.31.196:8888/TeaAPP/"
#define ShopDetailsURL @"http://192.168.31.196:8888/TeaAPP/images/category/"
#define ImageURL @"http://192.168.31.196:8888/TeaAPP/images/"
#define HTTPAgreement @"http://192.168.31.196:8888/TeaAPP/http.php"

#else

#define BaseUrl @"http://10.37.26.26/TeaAPP/"
#define ShopDetailsURL @"http://10.37.26.26/TeaAPP/images/category/"
#define ImageURL @"http://10.37.26.26/TeaAPP/images/"
#define HTTPAgreement @"http://10.37.26.26/TeaAPP/http.php"

#endif



@interface TeaHouseNetWorking : AFHTTPSessionManager
+ (instancetype)shareNetWorking;
@end
