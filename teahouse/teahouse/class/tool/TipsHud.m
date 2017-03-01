//
//  TipsHud.m
//  MallComponents
//
//  Created by holyjoy on 15/8/11.
//  Copyright (c) 2015年 holyjoy. All rights reserved.
//

#import "TipsHud.h"
#import "MBProgressHUD.h"
@interface TipsHud()
@property (nonatomic, strong) MBProgressHUD * hud;
@end

@implementation TipsHud

+ (TipsHud *)sharedInstance{
    static TipsHud * tipsHud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tipsHud = [[TipsHud alloc] init];
    });
    return tipsHud;
}

- (void)showLoadingOnView:(UIView *)view{
    if (_hud) {
        [_hud removeFromSuperview];
        _hud = nil;
    }
    _hud = [[MBProgressHUD alloc] initWithView:view];
    self.hud.mode = MBProgressHUDModeCustomView;
    [self.hud show:YES];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = _hud.center;
    NSArray *arrayM = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"loading1"],
                       [UIImage imageNamed:@"loading2"],
                       [UIImage imageNamed:@"loading3"],
                       [UIImage imageNamed:@"loading4"],
                       [UIImage imageNamed:@"loading5"],
                       [UIImage imageNamed:@"loading6"],
                       [UIImage imageNamed:@"loading7"],
                       [UIImage imageNamed:@"loading8"],
                       [UIImage imageNamed:@"loading9"],
                       [UIImage imageNamed:@"loading10"],
                       [UIImage imageNamed:@"loading11"],
                       [UIImage imageNamed:@"loading12"],
                       [UIImage imageNamed:@"loading13"],
                       [UIImage imageNamed:@"loading14"],nil];
    [imageView setAnimationImages:arrayM];
    [imageView setAnimationDuration:14*0.075];
    [imageView startAnimating];
    _hud.customView = imageView;
    [_hud setColor:[UIColor clearColor]];

    [view addSubview:_hud];

}

- (void)showTips:(NSString *)str{
    [_hud removeFromSuperview];
    _hud = nil;
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    _hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    
    _hud.mode = MBProgressHUDModeCustomView;
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor whiteColor];
    if (str.length > 0) {
        label.text = str;
        CGSize size =  [self sizeWithString:label.text font:label.font];
        label.frame = CGRectMake(0, 0, size.width, size.height);
        label.textAlignment = NSTextAlignmentCenter;
        _hud.customView = label;
        
        [keyWindow addSubview:_hud];
        
        [_hud show:YES];
        [self hideTips:[self displayDurationForString:label.text]];
        
        
    }else{
        [_hud hide:YES];
    }

}

-(void)hideTips{
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES];
    _hud = nil;
}

-(void)hideTips:(NSTimeInterval)delay{
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES afterDelay:delay];
    _hud = nil;
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(200, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

- (NSTimeInterval)displayDurationForString:(NSString*)string {
    return MIN((float)string.length*0.06 + 0.5, 3.0);
}

@end
