//
//  PLHomeArticalCell.h
//  Life
//
//  Created by qianfeng on 16/5/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLHomeArticalModel.h"

@interface PLHomeArticalCell : UITableViewCell

//图片
@property (nonatomic, strong) UIImageView *picImageView;
//作者
@property (nonatomic, strong) UILabel *autorLabel;
//书名
@property (nonatomic, strong) UILabel *titleLabel;


/**
 添加约束
 */
- (void)addContraninForCell;

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLHomeArticalModel *)model;

@end

