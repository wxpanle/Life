//
//  PLJokeCommentCell.h
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLJokeCommentModel.h"

@interface PLJokeCommentCell : UITableViewCell

//评论者姓名
@property (nonatomic, strong) UILabel *userNameLabel;

//评论者各人签名 + 内容
@property (nonatomic, strong) UILabel *descLabel;

//评论者头像
@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *titelLabel;

/**
 添加约束
 */
- (void)addContraninForCell;

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLJokeCommentModel *)model;
@end




