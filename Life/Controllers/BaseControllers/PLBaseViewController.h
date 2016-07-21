//
//  PLBaseViewController.h
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLBaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//左按钮
//@property (nonatomic, strong) UIButton *leftButton;

//右按钮
@property (nonatomic, strong) UIButton *rightButton;

/**
 左按钮事件
 */
//-(void)plAddLeftButtonAction:(SEL)selector;

/**
 右按钮事件
 */
-(void)plAddRightButtonAction:(SEL)selector;

/**
 创建返回按钮
 */
- (void)plCreateBackBarButtomItem;

@end
