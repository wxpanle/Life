//
//  PLAmuseLayoutCell.m
//  Life
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLAmuseLayoutCell.h"

@implementation PLAmuseLayoutCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self awakeFromNib];
    }
    
    return self;
}

- (void)awakeFromNib {
    //图片
    self.img_urlView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.img_urlView];
    
    //名字
    self.titleLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor darkGrayColor] font:17 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.titleLabel];
    
    //详情
    self.updateLabel = [FactoryUI plCreateLabelWithTextAlignment:NSTextAlignmentCenter textColor:[UIColor darkGrayColor] font:15 numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.updateLabel];
}

- (void)addContraninForCell {
    
    __weak typeof(self) weakSelf = self;
    
    [self.img_urlView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //上
        make.top.mas_equalTo(weakSelf.contentView);
        
        //下
        make.bottom.mas_equalTo(weakSelf.titleLabel.mas_top);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView);
        
        //宽
        make.width.mas_equalTo(SCREEN_W / 2 - 20);
        
        //高
        make.height.mas_equalTo((SCREEN_W / 2 - 20) * 4 / 3);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //下
        make.bottom.mas_equalTo(weakSelf.updateLabel.mas_top);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView);
    }];
    
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //下
        make.bottom.mas_equalTo(weakSelf.contentView);
        
        //左
        make.left.mas_equalTo(weakSelf.contentView);
        
        //右
        make.right.mas_equalTo(weakSelf.contentView);
    }];
}

- (void)plRefreshCellWithHomeLifeModel:(PLAmuseModel *)model {
    [self.img_urlView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
    
    self.titleLabel.text = model.title;

    NSString *tempStr = [NSString stringWithFormat:@"%@", model.update];
    if ([tempStr isEqualToString:@"0"]) {
        return;
    }
    
    self.updateLabel.text = [NSString stringWithFormat:@"%@",model.update];
}
@end
