//
//  PLJokeCell.h
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLJokeModel.h"

@protocol PLJokeCellShareProtocol <NSObject>

@optional
/**
 分享
 */
- (void)plShareJokeWithIndex:(NSInteger)index;

/**
 加载更多评论
 */
- (void)plCommentJokeWithIndex:(NSInteger)index;

- (void)plCommentJokeReplaceWithIndex:(NSInteger)index;

/**
 收藏笑话
 */
- (void)plCommentJokeCollectionWithIndex:(NSInteger)index;

/**
 取消收藏笑话
 */
- (void)plCommentJokeDisCollectionWithIndex:(NSInteger)index;

@end


@interface PLJokeCell : UITableViewCell

@property (nonatomic, weak) id <PLJokeCellShareProtocol> jokeDelegate;

//作者名字
@property (nonatomic, strong) UILabel *userNameLabel;

//作者头像
@property (nonatomic, strong) UIImageView *avatarImageView;

//段子内容
@property (nonatomic, strong) UILabel *contentLabel;

//赞按钮
@property (nonatomic, strong) UIButton *favoriteButton;

//赞个数
@property (nonatomic, strong) UILabel *favoriteLabel;

//评论按钮
@property (nonatomic, strong) UIButton *commentButton;

//评论个数
@property (nonatomic, strong) UILabel *commentLabel;

//分享按钮
@property (nonatomic, strong) UIButton *shareButton;

//分享次数
@property (nonatomic, strong) UILabel *shareLabel;

//收藏按钮
@property (nonatomic, strong) UIButton *collectButton;


/**
 添加约束
 */
- (void)addContraninForCell;

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLJokeModel *)model andIndex:(NSInteger)index;

@end



