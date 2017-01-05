//
//  GuideViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/23.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "GuideViewController.h"
#import "CustiomTabBarViewController.h"
@interface GuideViewController ()
<
    UIScrollViewDelegate
>
{
    UIScrollView *_scrollView;
    UIImageView *leftImageView;
    UIImageView *centerImageView;
    UIImageView *rightImageView;
    UIPageControl *pageControl;
    int currentImageIndex;//当前图片的索引数
    int imageCount;//轮播图片数
    NSTimer *timer;
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self loadImageData];//加载图片数据
    [self addScrollView];//添加滚动视图
    [self addImageViews];//添加图片视图
    [self addPageControl];//添加分页控件
    [self setDefaultImage];//设置默认图片
    
}
#pragma mark 加载/获取图片数据
- (void)loadImageData {
    imageCount = 3;
}

#pragma mark 添加滚动视图
- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.delegate = self;
    //设置contentsize(左中右三个图片)
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    //设置当前显示为中间的图片
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    //设置分页
    _scrollView.pagingEnabled = YES;
    //去掉垂直滚动条(防止上下滚动)
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}

#pragma mark 添加三个图片视图
- (void)addImageViews {
    //左
    leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:leftImageView];
    //中
    centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan)];
    [centerImageView addGestureRecognizer:tag];
    [_scrollView addSubview:centerImageView];
    //右
    rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:rightImageView];
}

#pragma mark 设置默认图片
- (void)setDefaultImage {
    leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",imageCount - 1]];
    centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",0]];
    rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",1]];
    currentImageIndex = 0;
    //设置当前页
    pageControl.currentPage = currentImageIndex;
}

#pragma mark 添加分页控件(显示图片页数的小白点)
- (void)addPageControl {
    pageControl = [[UIPageControl alloc] init];
    CGSize size = [pageControl sizeForNumberOfPages:imageCount];
    pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    pageControl.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 100);
    //默认颜色
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //当前页的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.numberOfPages = imageCount;
    [self.view addSubview:pageControl];
}

#pragma mark 停止滚动 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    //移动到中间
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    //设置分页
    pageControl.currentPage = currentImageIndex;
}

#pragma mark 重新加载图片
- (void)reloadImage {
    int leftImageIndex,rightImageIndex;
    CGPoint offset = [_scrollView contentOffset];
    if (offset.x > SCREEN_WIDTH) {//表示向右滑动
        currentImageIndex = (currentImageIndex + 1) % imageCount;
    }else if (offset.x <SCREEN_WIDTH) {//向左滑动
        currentImageIndex = (currentImageIndex + imageCount - 1) % imageCount;
    }
    centerImageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%d.png",currentImageIndex]];
    
    //重新设置左右图片
    leftImageIndex = (currentImageIndex + imageCount - 1) % imageCount;
    rightImageIndex = (currentImageIndex + 1) % imageCount;
    leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",leftImageIndex]];
    rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",rightImageIndex]];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
   //[self setTimer];
}

- (void)setTimer {
    timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerChanged {
    centerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",currentImageIndex]];
    
    int leftImageIndex,rightImageIndex;
    
    //重新设置左右图片
    leftImageIndex=(currentImageIndex+imageCount-1)%imageCount;
    NSLog(@"left----------%d",leftImageIndex);
    rightImageIndex=(currentImageIndex+1)%imageCount;
    NSLog(@"right----------%d",rightImageIndex);
    leftImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",leftImageIndex]];
    rightImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",rightImageIndex]];
    
    pageControl.currentPage=currentImageIndex;
    if (currentImageIndex==imageCount) {
        currentImageIndex=0;
    }
        currentImageIndex++;
}

- (void)touchesBegan {
    [UIApplication sharedApplication].windows.lastObject.rootViewController = [[CustiomTabBarViewController alloc] init];
}
@end
