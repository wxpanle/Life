//
//  PLTableHeaderView.h
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLTableHeaderView : UIView

@property (nonatomic, strong) NSArray *urlImageArray;

/**
 开始自动滚动视图
 */
- (void)plStartAutomaticScrollImage;

/**
 停止自动滚动视图
 */
- (void)plStopAutomaticScrollImage;

@end
