//
//  TeaHouseNetWorking.h
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define TEST

#ifdef TEST

#define BaseUrl @"http://119.29.196.89/TeaAPP/"
#define ShopDetailsURL @"http://119.29.196.89/TeaAPP/images/category/"
#define ImageURL @"http://119.29.196.89/TeaAPP/images/"
#define HTTPAgreement @"http://119.29.196.89/TeaAPP/http.html"

#else

#define BaseUrl @"http://10.37.26.26/TeaAPP/"
#define ShopDetailsURL @"http://10.37.26.26/TeaAPP/images/category/"
#define ImageURL @"http://10.37.26.26/TeaAPP/images/"
#define HTTPAgreement @"http://10.37.26.26/TeaAPP/http.php"

#endif

typedef void(^HTTPsuccess)(id responseObject);
typedef void(^HTTPfailure)(NSError *error);

@interface TeaHouseNetWorking : NSObject

/**  网络请求
     URLString      请求的url地址
     HUD            是否显示HUD
     parameters     请求的参数
     success        成功的回调
     failure        失败的回调
 */
+ (void)POST:(NSString *)URLString
     showHUD:(BOOL)HUD
  parameters:(id)parameters
     success:(HTTPsuccess)success
     failure:(HTTPfailure)failure;

/**  上传图片
    @param URLString    上传文件的 url 地址
    @param HUD          显示 HUD
    @param parameters   参数字典
    @param upImageName  图片名称
    @param success      成功
    @param failure      失败
 */
+ (void)upload:(NSString *)URLString
       showHUD:(BOOL)HUD
    parameters:(id)parameters
   upImageName:(NSString *)upImageName
       success:(HTTPsuccess)success
       failure:(HTTPfailure)failure;

@end
