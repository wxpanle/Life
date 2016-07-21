//
//  PLHomeLifeCell.m
//  Life
//
//  Created by qianfeng on 16/5/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLHomeLifeCell.h"

@implementation PLHomeLifeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    //选中颜色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //图片
    self.picImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picImageView];
    
    //标题
    self.titleLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor cyanColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.titleLabel];
}

/**
 添加约束
 */
- (void)addContraninForCell {
    
    __weak typeof(self) weakSelf = self;
    
    //标题约束
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左
        make.left.mas_equalTo(weakSelf.contentView);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView);
        
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(10);
        
        //下
        make.bottom.mas_equalTo(weakSelf.picImageView.mas_top).offset(-5);
        
    }];
    
    //图片约束
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左
        make.left.mas_equalTo(weakSelf.contentView);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-5);
        
        //高
        make.height.mas_equalTo(160);
        
    }];
    
}

/**
 刷新cell
 */
- (void)plRefreshCellWithHomeLifeModel:(PLHomeLifeModel *)model {
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    self.titleLabel.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
