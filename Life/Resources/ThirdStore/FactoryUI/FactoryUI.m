//
//  FactoryUI.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "FactoryUI.h"

@implementation FactoryUI

/**
 创建一个UIView
 */
+(UIView *)plCreateViewWithFrame:(CGRect)frame {
    
    UIView * view = [[UIView alloc]initWithFrame:frame];
    return view;
    
}

/**
 创建一个UILabel
 */
+(UILabel *)plCreateLabelWithTextAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor font:(CGFloat)fontSize numberOfLines:(NSInteger)numberOfLines lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    UILabel * label = [[UILabel alloc] init];

    //文字颜色
    label.textColor = textColor;
    
    //字体颜色
    label.font = [UIFont systemFontOfSize:fontSize];
    
    //设置对齐方式
    label.textAlignment = textAlignment;
    
    //设置折行
    label.numberOfLines = numberOfLines;
    
    //设置折行方式
    label.lineBreakMode = lineBreakMode;
    
    return label;
    
}

/**
 创建一个UIButton
 */
+(UIButton *)plCreateButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    //设置标题
    [button setTitle:title forState:UIControlStateNormal];
    //设置标题颜色
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    //设置图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    //设置响应事件
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

/**
 创建一个UIImageView
 */
+(UIImageView *)plCreateImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName {
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
    
}

/**
 创建一个UITextField
 */
+(UITextField *)plCreateTextFieldWithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder {
    
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    textField.text = text;
    textField.placeholder = placeHolder;
    return textField;
    
}
@end
