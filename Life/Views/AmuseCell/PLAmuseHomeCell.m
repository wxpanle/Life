//
//  PLAmuseHomeCell.m
//  Life
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLAmuseHomeCell.h"

@implementation PLAmuseHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    //图片
    self.amuseImageViewOne = [[UIImageView alloc] init];
    [self.contentView addSubview:self.amuseImageViewOne];
    
    self.amuseImageViewTwo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.amuseImageViewTwo];
    
    self.amuseImageViewThree = [[UIImageView alloc] init];
    [self.contentView addSubview:self.amuseImageViewThree];
    
    //名字
    self.amuseLabelOne = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.amuseImageViewOne addSubview:self.amuseLabelOne];
    
    self.amuseLabelTwo = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.amuseImageViewTwo addSubview:self.amuseLabelTwo];
    
    self.amuseLabelThree = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.amuseImageViewThree addSubview:self.amuseLabelThree];
    
    //详情
    self.briefLabelOne = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor grayColor] font:13 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.briefLabelOne];
    
    self.briefLabelTwo = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor grayColor] font:13 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.briefLabelTwo];
    
    self.briefLabelThree = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor grayColor] font:13 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.briefLabelThree];
}

- (void)addContraninForCell {
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat padding = 10.0f;
    //图片
    [self.amuseImageViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.amuseLabelOne.mas_top).offset(-padding);
        
        //宽
        make.width.mas_equalTo(@[weakSelf.amuseImageViewTwo, weakSelf.amuseImageViewThree]);
        
        //高
        make.height.mas_equalTo(@[weakSelf.amuseImageViewTwo, weakSelf.amuseImageViewThree]);
    }];
    
    [self.amuseImageViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewOne.mas_right).offset(padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.amuseLabelTwo.mas_top).offset(-padding);
        
    }];
    
    [self.amuseImageViewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        //上
        make.top.mas_equalTo(weakSelf.contentView).offset(padding);
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewTwo.mas_right).offset(padding);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //下
        make.bottom.mas_equalTo(weakSelf.amuseLabelThree.mas_top).offset(-padding);
    
        //高
        make.height.mas_equalTo((SCREEN_W - 30) / 3 * 4 / 3);
    }];
    
    //名字
    [self.amuseLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewOne.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.amuseImageViewOne.mas_right);
        
        //下
        make.bottom.mas_equalTo(weakSelf.briefLabelOne.mas_top).offset(-5);
        
    }];
    
    //名字
    [self.amuseLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewTwo.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.amuseImageViewTwo.mas_right);
        
        //下
       make.bottom.mas_equalTo(weakSelf.amuseLabelOne.mas_bottom);
        
    }];
    
    //名字
    [self.amuseLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewThree.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.amuseImageViewThree.mas_right);
        
        //下
        make.bottom.mas_equalTo(weakSelf.amuseLabelOne.mas_bottom);
        
    }];
    
    //详情
    [self.briefLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewOne.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.amuseImageViewOne.mas_right);
    }];
    
    [self.briefLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        //上
        make.top.mas_equalTo(weakSelf.amuseLabelTwo.mas_bottom).offset(5);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewTwo.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.amuseImageViewTwo.mas_right);
    }];
    
    [self.briefLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        //上
        make.top.mas_equalTo(weakSelf.amuseLabelThree.mas_bottom).offset(5);
        
        //下
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-padding);
        
        //左
        make.left.mas_equalTo(weakSelf.amuseImageViewThree.mas_left);
        
        //右
        make.right.mas_equalTo(weakSelf.amuseImageViewThree.mas_right);
    }];
    
}

- (void)plRefreshCellWithHomeLifeModelOne:(PLAmuseHomeModel *)modelOne ModelTwo:(PLAmuseHomeModel *)modelTwo ModelThree:(PLAmuseHomeModel *)modelThree {
    if (modelOne) {
        [self.amuseImageViewOne sd_setImageWithURL:[NSURL URLWithString:modelOne.img_url]];
        
        self.amuseLabelOne.text = modelOne.title;
        
        self.briefLabelOne.text = modelOne.brief;
    }
    
    if (modelOne) {
        [self.amuseImageViewTwo sd_setImageWithURL:[NSURL URLWithString:modelTwo.img_url]];
        
        self.amuseLabelTwo.text = modelTwo.title;
        
        self.briefLabelTwo.text = modelTwo.brief;
    }
    
    if (modelThree) {
        [self.amuseImageViewThree sd_setImageWithURL:[NSURL URLWithString:modelThree.img_url]];
        
        self.amuseLabelThree.text = modelThree.title;
        
        self.briefLabelThree.text = modelThree.brief;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
