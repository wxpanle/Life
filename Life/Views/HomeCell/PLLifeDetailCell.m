//
//  PLLifeDetailCell.m
//  Life
//
//  Created by qianfeng on 16/5/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLLifeDetailCell.h"

@implementation PLLifeDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //图片
    self.picLeftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picLeftImageView];
    
    self.picRightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picRightImageView];
    
    //题目
    self.titleLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor cyanColor] font:20 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.titleLabel];
    
    //详情
    self.decLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor lightGrayColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.decLabel];
}

/**
 添加约束
 */
- (void)addContraninForCell {
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat padding = 10;
    
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView);
        
        //下
        make.bottom.mas_equalTo(weakSelf.picLeftImageView.mas_top).offset(-padding);
    }];
    
    //左图片
    [self.picLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左
        make.left.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //右
        make.right.mas_equalTo(weakSelf.picRightImageView.mas_left).offset(-padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.decLabel.mas_top).offset(-padding);
        
        //宽
        make.width.mas_equalTo(weakSelf.picRightImageView.mas_width);
        
        //高
        make.height.mas_equalTo(weakSelf.picRightImageView.mas_width);
    }];
    
    //右图片
    [self.picRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.decLabel.mas_top).offset(-padding);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //高
        make.height.mas_equalTo(weakSelf.picLeftImageView.mas_width);
    }];
    
    //详情
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-padding);
    }];
}

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLHomeMiddleLifeModel *)model {
    
    if (model.pic.count == 1) {
        [self.picLeftImageView sd_setImageWithURL:[NSURL URLWithString:[model.pic.firstObject objectForKey:@"pic"]]];
        [self.picRightImageView sd_setImageWithURL:[NSURL URLWithString:[model.pic.firstObject objectForKey:@"pic"]]];
    } else if (model.pic.count >= 2) {
        [self.picLeftImageView sd_setImageWithURL:[NSURL URLWithString:[model.pic.firstObject objectForKey:@"pic"]]];
        [self.picRightImageView sd_setImageWithURL:[NSURL URLWithString:[model.pic.lastObject objectForKey:@"pic"]]];
    }
    
    self.titleLabel.text = model.title;
    
    self.decLabel.text = model.desc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
