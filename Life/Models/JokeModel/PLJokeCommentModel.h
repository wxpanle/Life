//
//  PLJokeCommentModel.h
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLJokeCommentModel : NSObject <NSCoding>

//评论者姓名
@property (nonatomic, copy) NSString *user_name;

//评论者各人签名
@property (nonatomic, copy) NSString *desc;

//评论者头像
@property (nonatomic, copy) NSString *avatar_url;

//评论者话语
@property (nonatomic, copy) NSString *text;

@end


//{
//    "user_id": 6549279038,
//    "description": "",
//    "bury_count": 0,
//    "avatar_url": "",
//    "text": "没毛病",
//    "user_verified": false,
//    "digg_count": 0,
//    "user_profile_image_url": "",
//    "platform_id": "feifei",
//    "platform": "feifei",
//    "create_time": 1464652983,
//    "user_digg": 0,
//    "group_id": 6630103504,
//    "user_name": "工人小张",
//    "id": 6639579569,
//    "user_bury": 0
//},