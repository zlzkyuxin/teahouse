//
//  UserCenterTopView.m
//  teahouse
//
//  Created by yuxin on 2017/5/6.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "UserCenterTopView.h"

#define UserIconRadius 80

@interface UserCenterTopView()

@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UIView *upView;
@property (nonatomic , strong) UIView *bottomView;
@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
@property (nonatomic , strong) UIView *line3;

@end


@implementation UserCenterTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化界面
        [self initView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化界面
        [self initView];
    }
    return self;
}

- (void)setUserInfo:(LoginModel *)userInfo {
    _userInfo = userInfo;
    //设置frame
    [self setFrame];
    //设置数据
    [self setData];
}

//初始化界面
- (void)initView {
    //头部最底层容器
    UIView *backView = [UIView new];
    _backView = backView;
    [self addSubview:backView];
    
    //上半部
    UIView *upView = [UIView new];
    _upView = upView;
    [backView addSubview:upView];
    
    //下半部
    UIView *bottomView = [UIView new];
    _bottomView = bottomView;
    [backView addSubview:bottomView];
    
    //头像
    _userIconImage = [UIImageView new];
    [backView addSubview:_userIconImage];
    
    //用户名
    _userNameLabel = [UILabel new];
    [bottomView addSubview:_userNameLabel];
    
    //用户名底部分割线
    UIView *line1 = [UIView new];
    _line1 = line1;
    [bottomView addSubview:line1];
    
    //垂直分割线
    UIView *line2 = [UIView new];
    _line2 = line2;
    [bottomView addSubview:line2];
    
    //底部分割线
    UIView *line3 = [UIView new];
    _line3 = line3;
    [bottomView addSubview:line3];

}

//设置frame
- (void)setFrame {
    WS(weakSelf)
    //头部最底层容器
    _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //上半部
    _upView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _backView.frame.size.height / 2);
    //下半部
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_upView.frame), SCREEN_WIDTH, _backView.frame.size.height / 2);
    //头像
    [_userIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.backView.mas_centerX);
        make.centerY.equalTo(weakSelf.backView.mas_centerY).offset(-UserIconRadius/4);
        make.width.mas_equalTo(UserIconRadius);
        make.height.mas_equalTo(UserIconRadius);
    }];
    //用户名
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bottomView);
        make.right.equalTo(weakSelf.bottomView);
        make.height.mas_equalTo(@20);
        make.centerY.equalTo(weakSelf.bottomView.mas_centerY).offset(-25);
    }];
    //用户名底部分割线
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bottomView);
        make.right.equalTo(weakSelf.bottomView);
        make.height.mas_equalTo(@0.5);
        make.centerY.equalTo(weakSelf.bottomView.mas_centerY);
    }];
    //垂直分割线
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset(8);
        make.bottom.equalTo(weakSelf.bottomView).offset(-8);
        make.width.mas_equalTo(@0.5);
        make.centerX.equalTo(weakSelf.bottomView.mas_centerX);
    }];
    //底部分割线
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bottomView);
        make.right.equalTo(weakSelf.bottomView);
        make.height.mas_equalTo(@0.5);
        make.bottom.equalTo(weakSelf.bottomView);
    }];
}

//设置数据
- (void)setData {
    //上半部
    _upView.backgroundColor = [UIColor greenColor];
    //下半部
    _bottomView.backgroundColor = [UIColor whiteColor];
    //刷新本地缓存图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@userimage/%@",ImageURL,_userInfo.userImage]];
    [_userIconImage sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageRefreshCached];
    
    _userIconImage.layer.cornerRadius = UserIconRadius / 2;
    _userIconImage.layer.masksToBounds = YES;
    //给头像添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconImageClick)];
    _userIconImage.userInteractionEnabled = YES;
    [_userIconImage addGestureRecognizer:tap];
    //用户名
    _userNameLabel.text = _userInfo.userNick;
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    //用户名底部分割线
    _line1.backgroundColor = UIColorFromHexadecimalRGB(0xcccccc);
    //垂直分割线
    _line2.backgroundColor = UIColorFromHexadecimalRGB(0xcccccc);
    //底部分割线
    _line3.backgroundColor = UIColorFromHexadecimalRGB(0xcccccc);
}

- (void)userIconImageClick {
    if (_block) {
        _block();
    }
}



@end