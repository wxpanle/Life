//
//  PLJokeCommentCell.m
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLJokeCommentCell.h"

@implementation PLJokeCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor lightTextColor];
    
    //评论者姓名
    self.userNameLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.userNameLabel];
    
    //评论者各人签名
    self.descLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor lightGrayColor] font:14 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.descLabel];
    
    //评论者头像
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.cornerRadius = 10;
    self.avatarImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.avatarImageView];
    
    //
    self.titelLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentRight textColor:[UIColor redColor] font:14 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    self.titelLabel.text = @"精彩评论";
    [self.contentView addSubview:self.titelLabel];
}

/**
 添加约束
 */
- (void)addContraninForCell {
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat paddingOne = 10.0;
    CGFloat paddingTwo = 5.0;
    CGFloat paddingThird = 15.0;
    
    //评论者姓名
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(paddingTwo);
        
        //下
        make.bottom.mas_equalTo(weakSelf.descLabel.mas_top).offset(-paddingTwo);
        
        //左
        make.left.mas_equalTo(weakSelf.avatarImageView.mas_right).offset(paddingTwo);
        
        //右
        make.right.mas_equalTo(weakSelf.titelLabel.mas_left);
        
    }];
    
    //评论者各人签名
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-paddingTwo);
        
        //左
        make.left.mas_equalTo(weakSelf.userNameLabel.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-paddingOne);
    }];
    
    //评论者头像
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(paddingTwo);
        
        //下
        make.bottom.mas_equalTo(weakSelf.descLabel.mas_top).offset(-paddingThird);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView).offset(30);
        
        //宽
        make.width.mas_equalTo(30);
        
        //高
        make.height.mas_equalTo(30);
    }];
    
    //
    [self.titelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(paddingOne);
        
        //下
        make.bottom.mas_equalTo(weakSelf.descLabel.mas_top).offset(-paddingTwo);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-paddingTwo);
    }];
}

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLJokeCommentModel *)model {
    
    //评论者姓名
    self.userNameLabel.text = model.user_name;
    
    //评论者各人签名 + 内容
    if ([model.desc isEqualToString:@""]) {
        self.descLabel.text = [NSString stringWithFormat:@"%@\n        ---楼主很懒，什么也没有留下", model.text];
    } else if (model.desc.length >= 1) {
        self.descLabel.text = [NSString stringWithFormat:@"%@\n        ---%@", model.text, model.desc];
    }
    
    //评论者头像
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"joke_palcehold"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
