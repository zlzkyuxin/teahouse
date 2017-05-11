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

+ (instancetype)shareNetWorking {
    static TeaHouseNetWorking *_thNetWorking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _thNetWorking = [[TeaHouseNetWorking alloc] initWithBaseURL:[NSURL URLWithString:httpBaseURLString]];
        _thNetWorking.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/javascript", nil];
        _thNetWorking.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _thNetWorking.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        _thNetWorking.requestSerializer.timeoutInterval = 10;
    });
    return _thNetWorking;
}


@end




@interface TeaHouseHTTPClient ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation TeaHouseHTTPClient

DECLARE_SINGLETON(TeaHouseHTTPClient)

- (id)init {
    if (self) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:httpBaseURLString]];
        
        //        _manager.securityPolicy = [self customSecurityPolicy];
        
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
//         _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/javascript", nil];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript", nil];
        
        _manager.requestSerializer.timeoutInterval = 0;
//        _manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    }
    return self;
}

- (NSURLSessionTask *)POST:(NSString *)URLString
                   showHUD:(BOOL)HUD
                parameters:(id)parameters
                   success:(HTTPClientsuccess)success
                   failure:(HTTPClientfailure)failure {
    if (HUD) {
        [MBProgressHUD showMessage:@"光速请求中,请稍等..."];
    }
    NSURLSessionTask *task = [_manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUD];
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        failure(error);
    }];
    return task;
}


@end
