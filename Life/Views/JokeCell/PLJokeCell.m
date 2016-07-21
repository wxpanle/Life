//
//  PLJokeCell.m
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLJokeCell.h"

@implementation PLJokeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    //作者名字
    self.userNameLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:17 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.userNameLabel];
    
    //作者头像
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.cornerRadius = 10;
    self.avatarImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.avatarImageView];
    
    //段子内容
    self.contentLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:14 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.contentLabel];
    
    //赞按钮
    self.favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.favoriteButton setImage:[[UIImage imageNamed:@"joke_zan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.favoriteButton setImage:[[UIImage imageNamed:@"joke_zan_g"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [self.favoriteButton addTarget:self action:@selector(plJokeZanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.favoriteButton];
    
    //赞个数
    self.favoriteLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.favoriteLabel];
    
    //评论按钮
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentButton setImage:[[UIImage imageNamed:@"joke_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.commentButton addTarget:self action:@selector(plJokeCommentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.commentButton];
    
    //评论个数
    self.commentLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.commentLabel];
    
    //分享按钮
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setImage:[[UIImage imageNamed:@"joke_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(plJokeShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.shareButton];
    
    //分享次
    self.shareLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:14 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.shareLabel];
    
    //收藏按钮
    self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectButton setImage:[[UIImage imageNamed:@"Home_Detail_Collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.collectButton setImage:[[UIImage imageNamed:@"Home_Detail_Collection-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [self.collectButton addTarget:self action:@selector(plJokeCollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.collectButton];
}

/**
 添加约束
 */
- (void)addContraninForCell {
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat paddingOne = 10.0;
    CGFloat paddingTwo = 5.0;
    CGFloat paddingThird = 15.0;
    
    //作者名字
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(paddingOne);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentLabel.mas_top).offset(-paddingThird);
        
        //左
        make.left.mas_equalTo(weakSelf.avatarImageView.mas_right).offset(paddingTwo);
        
        //右
        make.right.mas_equalTo(weakSelf.collectButton.mas_left).offset(-paddingOne);
        
    }];
    
    //收藏按钮
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(paddingTwo);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentLabel.mas_top).offset(-paddingTwo);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-paddingThird);
        
        //宽
        make.width.mas_equalTo(40.0f);
    }];
    
    //作者头像
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(paddingOne);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentLabel.mas_top).offset(-paddingThird);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView).offset(paddingTwo);
        
        //宽
        make.width.mas_equalTo(35);
        
        //高
        make.height.mas_equalTo(35);

    }];
    
    //段子内容
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //下
        make.bottom.mas_equalTo(weakSelf.favoriteButton.mas_top).offset(-paddingThird);
        
        //左
        make.left.mas_equalTo(weakSelf.userNameLabel.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-paddingThird);
        
    }];
    
    //赞按钮
    [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-paddingOne);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView).offset(paddingTwo);
        
        //右
        make.right.mas_equalTo(weakSelf.favoriteLabel.mas_left).offset(-paddingTwo);
        
        //宽
        make.width.mas_equalTo(20);
        
        //高
        make.height.mas_equalTo(20);
        
    }];
    
    //赞个数
    [self.favoriteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).offset(paddingThird);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-paddingOne);
        
        //右
        make.right.mas_equalTo(weakSelf.commentButton.mas_left);

    }];
    
    //评论按钮
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).offset(paddingThird);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-paddingOne);
        
        //左
        make.left.mas_equalTo(SCREEN_W / 2.0 - 25);
        
        //右
        make.right.mas_equalTo(weakSelf.commentLabel.mas_left).offset(-paddingTwo);
        
        //宽
        make.width.mas_equalTo(20);
        
    }];
    
    //评论个数
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).offset(paddingThird);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-paddingOne);
        
        //右
        make.right.mas_equalTo(weakSelf.shareButton.mas_left);
        
    }];
    
    //分享按钮
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).offset(paddingThird);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-paddingOne);
        
        //右
        make.right.mas_equalTo(weakSelf.shareLabel.mas_left).offset(-paddingTwo);
        
        //宽
        make.width.mas_equalTo(20);
        
    }];
    
    //分享次数
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).offset(paddingThird);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-paddingOne);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-paddingTwo);
        
        //宽
        make.width.mas_equalTo(40);

    }];
}

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLJokeModel *)model andIndex:(NSInteger)index{
    
    //作者名字
    self.userNameLabel.text = model.userName;
    
    //作者头像
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"joke_palcehold"]];
    
    //段子内容
    self.contentLabel.text = model.content;
    
    //赞个数
    self.favoriteLabel.text = [NSString stringWithFormat:@"%@",model.favorite_count];

    //评论个数
    self.commentLabel.text = [NSString stringWithFormat:@"%@",model.comment_count];
    
    //分享次数
    self.shareLabel.text = [NSString stringWithFormat:@"%@",model.share_count];
    
    //给分享按钮添加tag值
    self.shareButton.tag = 100 + index;
    
    //给评论按钮添加tag值
    self.commentButton.tag = 1000 + index;
    
    //给收藏按钮添加tag值
    self.collectButton.tag = 10000 + index;
    
    //查找数据库判断当前的状态
    [self plSearchCoreDataToSwitchCollectButtonStateWithID:model.ID];
}

#pragma  mark ----查找数据库改变收藏按钮状态----
- (void)plSearchCoreDataToSwitchCollectButtonStateWithID:(NSNumber *)ID {
    
    NSArray *array = [PLCoreJokeModel MR_findByAttribute:@"dataID" withValue:ID];
    
    if (array.count == 1) {
        self.collectButton.selected = YES;
    } else {
        self.collectButton.selected = NO;
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

#pragma mark ----赞 分享 评论按钮----
- (void)plJokeZanButtonAction:(UIButton *)btn {
    
}

- (void)plJokeCommentButtonAction:(UIButton *)btn {
    
    [self.jokeDelegate plCommentJokeWithIndex:self.commentButton.tag - 1000];
    
}

- (void)plJokeShareButtonAction:(UIButton *)btn {

    [self.jokeDelegate plShareJokeWithIndex:self.shareButton.tag - 100];
}

- (void)plJokeCollectButtonAction:(UIButton *)btn {
    if (self.collectButton.selected == NO) {
        self.collectButton.selected = YES;
        
        [self.jokeDelegate plCommentJokeCollectionWithIndex:self.collectButton.tag - 10000];
        
    } else if (self.collectButton.selected == YES) {
        self.collectButton.selected = NO;
        [self.jokeDelegate plCommentJokeDisCollectionWithIndex:self.collectButton.tag - 10000];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
