//
//  Header.h
//  teahouse
//
//  Created by yuxin on 2016/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#ifndef Header_h
#define Header_h

//字体
#define APP_FONT(fsize) [UIFont systemFontOfSize:fsize]

//是否可用手机号
#define IsAvailablePhoneNumber(phoneNumber) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1([3578]\\d|4[57])\\d{8}$"] evaluateWithObject:phoneNumber]

//容错
#define ARRAY_OBJ_AT(index) My_objectAtIndex:(index) File:__FILE__ Line:__LINE__
#define ARRAY_ADD_OBJ(obj) My_addObject:(obj) File:__FILE__ Line:__LINE__
#define ARRAY_ADD_OBJS_FROM_ARRAY(objs) My_addObjectsFromArray:(objs) File:__FILE__ Line:__LINE__
#define ARRAY_INSERT_OBJ_AT(obj,index)My_insertObject:(obj) atIndex:index File:__FILE__ Line:__LINE__
#define ARRAY_REMOVEOBJ_AT(index) My_removeObjectAtIndex:(index) File:__FILE__ Line:__LINE__
#define ARRAY_REMOVE_ALLOBJ My_removeAllObjects_File:__FILE__ Line:__LINE__
#define ARRAY_REMOVE_OBJ(obj) My_removeObject:(obj) File:__FILE__ Line:__LINE__
#define ARRAY_JOIN_BY(sep) MY_joinByString:(sep) File:__FILE__ Line:__LINE__

#define DICT_SET_VK(value,key) My_setObject:value forKey:key File:__FILE__ Line:__LINE__
#define DICT_SET_DICT(dict) My_setDict:dict File:__FILE__ Line:__LINE__
#define DICT_HAS_K(key) My_hasKey:key File:__FILE__ Line:__LINE__
#define DICT_REMOVEOBJ_K(key) My_removeObjectForKey:key File:__FILE__ Line:__LINE__
#define DICT_REMOVEOBJS_KS(keys) My_removeObjectsForKeys:keys File:__FILE__ Line:__LINE__
#define DICT_OBJ_FOR_K(key) My_objectForKey:(key) File:__FILE__ Line:__LINE__
#define DICT_ALL_KS My_allKeys_File:__FILE__ Line:__LINE__
#define DICT_ALL_VS My_allValues_File:__FILE__ Line:__LINE__
#define DICT_REMOVE_ALLOBJ My_removeAllObjects_File:__FILE__ Line:__LINE__

#define COUNT My_count_File:__FILE__ Line:__LINE__

#define BASE_COLOR UIColorFromHexadecimalRGB(0x76cb07)

//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define UIColorFromHexadecimalRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  获取屏幕宽度与高度
 */
#define SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SCREEN_NAVIHEIGHT (44 + 20)
#define SCREEN_TABBARHEIGHT 49

/**
 *  获取通知中心
 */
#define GETNotificationCenter [NSNotificationCenter defaultCenter]

/**
 *  设置随机颜色
 */
#define SETRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/**
 *  设置RGB颜色/设置RGBA颜色
 */
#define SETRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LRRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// clear背景颜色
#define SETClearColor [UIColor clearColor]

/**
 *  自定义高效率的 NSLog
 */
#ifdef DEBUG
#define TEALog(...) NSLog(@"%s 第%d行 \n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define TEALog(...)
#endif

/**
 *  弱引用/强引用
 */
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;

/**
 *  设置 view 圆角和边框
 */
#define SETViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/**
 *  由角度转换弧度 由弧度转换角度
 */
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)

/**
 *  设置加载提示框（第三方框架：Toast）
 
 此宏定义非常好用，但是小伙伴需要CocoaPods导入第三方框架：Toast
 使用方法如下：
 LRToast(@"网络加载失败");
 */
#define LRToast(str)              CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[kWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
kWindow.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
kWindow.userInteractionEnabled = YES;\
});\


///声明为单例类
///需要在@interface中声明以下函数原型
///+ (className *)sharedInstance
#define DECLARE_SINGLETON_B(className) \
static className *singletonInstance = nil; \
\
+ (className *)sharedInstance { \
@synchronized (self) { \
if (!singletonInstance) { \
[[self alloc] init]; \
} \
} \
return singletonInstance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized (self) { \
if (!singletonInstance) { \
singletonInstance = [super allocWithZone:zone]; \
return singletonInstance; \
} \
} \
return nil; \
} \
\

#define DECLARE_SINGLETON_A(className) \
static className *singletonInstance = nil; \
+ (className *)sharedInstance { \
@synchronized (self) { \
if (!singletonInstance) { \
singletonInstance = [[self alloc] init]; \
} \
return singletonInstance; \
} \
} \

#ifdef DEBUG
#define DECLARE_SINGLETON DECLARE_SINGLETON_A
#else
#define DECLARE_SINGLETON DECLARE_SINGLETON_B
#endif

/**
 *  设置加载提示框（第三方框架：MBProgressHUD）
 */
// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define kWindow [UIApplication sharedApplication].keyWindow

#define kBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \

#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()

#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]

#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()

/**
 *  获取view的frame/图片资源
 */
//获取view的frame
#define GetViewWidth(view)  view.frame.size.width
#define GetViewHeight(view) view.frame.size.height
#define GetViewX(view)      view.frame.origin.x
#define GetViewY(view)      view.frame.origin.y
//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

/**
 *  获取当前语言
 */
#define GETCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/**
 *  使用 ARC 和 MRC
 */
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

/**
 *  判断当前的iPhone设备/系统版本
 */
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

/**
 *  判断是真机还是模拟器
 */
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

/**
 *  沙盒目录文件
 */
//获取temp
#define GETPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define GETPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define GETPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#endif /* Header_h */
