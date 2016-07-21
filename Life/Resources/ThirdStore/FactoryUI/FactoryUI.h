//
//  FactoryUI.h
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactoryUI : NSObject

//利用工厂模式，将基本控件用静态方法创建

/**
 创建一个UIView
 */
+ (UIView *)plCreateViewWithFrame:(CGRect)frame;

/**
 创建一个UILabel
 */
+ (UILabel *)plCreateLabelWithTextAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor font:(CGFloat)fontSize numberOfLines:(NSInteger)numberOfLines lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 创建一个UIButton
 */
+ (UIButton *)plCreateButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector;

/**
 创建一个UIImageView
 */
+ (UIImageView *)plCreateImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;

/**
 创建一个UITextField
 */
+ (UITextField *)plCreateTextFieldWithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder;

@end
