//
//  GoodsDetailTableViewCellB.h
//  teahouse
//
//  Created by zlzk on 2017/4/14.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)();

@interface GoodsDetailTableViewCellB : UITableViewCell

@property (nonatomic , strong)btnClickBlock block;

@end
