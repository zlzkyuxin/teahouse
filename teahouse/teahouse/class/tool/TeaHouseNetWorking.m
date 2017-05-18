//
//  TeaHouseNetWorking.m
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "TeaHouseNetWorking.h"

static NSString * const httpBaseURLString = BaseUrl;

@implementation TeaHouseNetWorking

+ (void)POST:(NSString *)URLString
     showHUD:(BOOL)HUD
 showMessage:(NSString *)message
  parameters:(id)parameters
     success:(HTTPsuccess)success
     failure:(HTTPfailure)failure {
    if (HUD) {
        if (message.length == 0) {
            message = @"正在加载中";
        }
        [MBProgressHUD showMessage:message];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];
    TEALog(@"--请求url地址--%@\n",url);
    TEALog(@"----请求参数%@\n",parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript", nil];
    manager.requestSerializer.timeoutInterval = 10;
    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUD];
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        TEALog(@"----请求返回的结果%@\n",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        TEALog(@"----请求失败错误%@\n",error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)upload:(NSString *)URLString
       showHUD:(BOOL)HUD
    parameters:(id)parameters
   upImageName:(NSString *)upImageName
       success:(HTTPsuccess)success
       failure:(HTTPfailure)failure {
    if (HUD) {
        [MBProgressHUD showMessage:@"正在上传中"];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];
    TEALog(@"--请求url地址--%@\n",url);
    TEALog(@"----请求参数%@\n",parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript", nil];
    manager.requestSerializer.timeoutInterval = 0;
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = [NSData dataWithContentsOfFile:[UIImage getPNGImageFilePathFromCache:upImageName]];
        [formData appendPartWithFileData:imageData name:@"header" fileName:upImageName mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUD];
        TEALog(@"----> %@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUD];
        TEALog(@"----> %@",error.domain);
        if (failure) {
            failure(error);
        }
    }];
}


/** 检查网络状态*/
+ (void)checkNetWork{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                //AFNetworkReachabilityStatusUnknown          = -1,
                //AFNetworkReachabilityStatusNotReachable     = 0,
                //AFNetworkReachabilityStatusReachableViaWWAN = 1,
                //AFNetworkReachabilityStatusReachableViaWiFi = 2,
            case AFNetworkReachabilityStatusUnknown:
                TEALog(@"未知网络");
                // 设置网络请求的缓存政策
                manager.requestSerializer.cachePolicy =  NSURLRequestReturnCacheDataElseLoad;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                TEALog(@"断网状态");
                // 设置网络请求的缓存政策
                manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                TEALog(@"4G网络");
                // 设置网络请求的缓存政策
                manager.requestSerializer.cachePolicy =  NSURLRequestReturnCacheDataElseLoad;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                TEALog(@"WIFi");
                // 设置网络请求的缓存政策
                manager.requestSerializer.cachePolicy =  NSURLRequestReloadIgnoringLocalCacheData;
                break;
            default:
                break;
        }
    }];
    // 启动网络状态监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


+ (NSString *)dictToStr:(id)params {
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, [params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    result = (NSMutableString *)[result substringWithRange:NSMakeRange(0, result.length - 1)];
    return result;
}

@end
