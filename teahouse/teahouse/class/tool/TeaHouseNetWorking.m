//
//  TeaHouseNetWorking.m
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "TeaHouseNetWorking.h"

static NSString * const httpBaseURLString = @"http://192.168.1.119:8888/TeaAPP/";

@implementation TeaHouseNetWorking

+(instancetype)shareNetWorking {
    static TeaHouseNetWorking *_thNetWorking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _thNetWorking = [[TeaHouseNetWorking alloc] initWithBaseURL:[NSURL URLWithString:httpBaseURLString]];
        _thNetWorking.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/javascript", nil];
        _thNetWorking.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _thNetWorking.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        _thNetWorking.requestSerializer.timeoutInterval = 20;
    });
    return _thNetWorking;
}

@end
