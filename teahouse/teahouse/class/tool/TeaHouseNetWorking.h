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

#define BaseUrl @"http://119.29.113.73/TeaAPP/"
#define ShopDetailsURL @"http://119.29.113.73/TeaAPP/images/category/"
#define ImageURL @"http://119.29.113.73/TeaAPP/images/"
#define HTTPAgreement @"http://119.29.113.73/TeaAPP/http.html"

#else

#define BaseUrl @"http://10.37.26.26/TeaAPP/"
#define ShopDetailsURL @"http://10.37.26.26/TeaAPP/images/category/"
#define ImageURL @"http://10.37.26.26/TeaAPP/images/"
#define HTTPAgreement @"http://10.37.26.26/TeaAPP/http.php"

#endif



@interface TeaHouseNetWorking : AFHTTPSessionManager
+ (instancetype)shareNetWorking;
@end
