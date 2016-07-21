//
//  PLAmuseLayoutCell.h
//  Life
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLAmuseModel.h"

@interface PLAmuseLayoutCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *img_urlView;
@property (nonatomic, strong) UILabel *updateLabel;

/**
 添加约束
 */
- (void)addContraninForCell;

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLAmuseModel *)model;

@end
