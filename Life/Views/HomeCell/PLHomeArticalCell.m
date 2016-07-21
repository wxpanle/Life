//
//  PLHomeArticalCell.m
//  Life
//
//  Created by qianfeng on 16/5/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLHomeArticalCell.h"

@implementation PLHomeArticalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    //图片
    self.picImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picImageView];
    
    //作者
    self.autorLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.autorLabel];
    
    //题目
    self.titleLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:17 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.titleLabel];
    
}

/**
 添加约束
 */
- (void)addContraninForCell {
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat padding = 10;
    //图片
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左
        make.left.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //右
        make.right.mas_equalTo(weakSelf.autorLabel.mas_left).offset(-padding);
        
        //宽
        make.width.mas_equalTo(105);
        
        //高
        make.height.mas_equalTo(110);
        
    }];
    
    //作者
    [self.autorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.titleLabel.mas_top).offset(-padding);
        
        //高
        make.height.mas_equalTo(30);
    }];
    
    //书名
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左
        make.left.mas_equalTo(weakSelf.picImageView.mas_right).offset(padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-padding);
    }];
}

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLHomeArticalModel *)model {
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    self.autorLabel.text = model.author;
    
    self.titleLabel.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
