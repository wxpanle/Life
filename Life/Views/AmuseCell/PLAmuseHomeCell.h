//
//  PLAmuseHomeCell.h
//  Life
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLAmuseHomeModel.h"

@interface PLAmuseHomeCell : UITableViewCell

//图片
@property (nonatomic, strong) UIImageView *amuseImageViewOne;
@property (nonatomic, strong) UIImageView *amuseImageViewTwo;
@property (nonatomic, strong) UIImageView *amuseImageViewThree;

//标题
@property (nonatomic, strong) UILabel *amuseLabelOne;
@property (nonatomic, strong) UILabel *amuseLabelTwo;
@property (nonatomic, strong) UILabel *amuseLabelThree;

//详情
@property (nonatomic, strong) UILabel *briefLabelOne;
@property (nonatomic, strong) UILabel *briefLabelTwo;
@property (nonatomic, strong) UILabel *briefLabelThree;


/**
 添加约束
 */
- (void)addContraninForCell;

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModelOne:(PLAmuseHomeModel *)modelOne ModelTwo:(PLAmuseHomeModel *)modelTwo ModelThree:(PLAmuseHomeModel *)modelThree;

@end
