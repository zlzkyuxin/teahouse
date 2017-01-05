//
//  HotGoodsTableViewCell.h
//  teahouse
//
//  Created by yuxin on 2017/1/3.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotGoodsModel;
@interface HotGoodsTableViewCell : UITableViewCell
@property (nonatomic , strong)HotGoodsModel *model;
@property (nonatomic , assign)CGFloat cellHeight;//高度
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
