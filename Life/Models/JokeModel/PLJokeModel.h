//
//  PLJokeModel.h
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLJokeModel : NSObject

//内容
@property (nonatomic, copy) NSString *content;

//作者名
@property (nonatomic, copy) NSString *userName;

//作者头像
@property (nonatomic, copy) NSString *avatar_url;

//分享次数
@property (nonatomic, strong) NSNumber *share_count;

//评论总数
@property (nonatomic, strong) NSNumber *comment_count;

//喜欢总数
@property (nonatomic, strong) NSNumber *favorite_count;

//分享链接
@property (nonatomic, copy) NSString *share_url;

//评论的数组
@property (nonatomic, strong) NSMutableArray *commentArray;

//id
@property (nonatomic, strong) NSNumber *ID;


@end


//"favorite_count": 1691,
//
//"share_url": "http://m.neihanshequ.com/share/group/6280798266/?iid=0&app=joke_essay",
//"content": "请客户去KTV，经理带几个妹纸进来，竟然有我未来小姨子！我怕客户点她太尴尬，赶紧点她坐我身边，然后故作镇定对客户说：呵呵，我就喜欢这种清纯型的。\n客户大嘴一咧，趴我耳边说：兄弟你看走眼啦，她有个姐姐，姐俩一块出苔才800，浪得很啊！",
//"comment_count": 1076,
//"share_count": 2383,
//"user": {
//    "name": "蛋吊红肿",
//    "avatar_url": "http://p2.pstatp.com/thumb/8111/743018184",



