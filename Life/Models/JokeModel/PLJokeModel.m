//
//  PLJokeModel.m
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLJokeModel.h"

@implementation PLJokeModel

- (instancetype)init {
    if (self = [super init]) {
        self.commentArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ %@", self.comment_count, self.share_count, self.favorite_count, self.content, self.userName, self.avatar_url, self.share_url, self.commentArray];
}
@end
