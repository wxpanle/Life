//
//  PLLifeDetailCell.h
//  Life
//
//  Created by qianfeng on 16/5/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLHomeMiddleLifeModel.h"

@interface PLLifeDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *picLeftImageView;
@property (nonatomic, strong) UIImageView *picRightImageView;
@property (nonatomic, strong) UILabel *decLabel;

/**
 添加约束
 */
- (void)addContraninForCell;

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLHomeMiddleLifeModel *)model;
@end
