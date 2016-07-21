//
//  PLJokeCommentModel.m
//  Life
//
//  Created by qianfeng on 16/5/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLJokeCommentModel.h"

@implementation PLJokeCommentModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.user_name forKey:@"user_name"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.avatar_url forKey:@"avatar_url"];
    [aCoder encodeObject:self.text forKey:@"text"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.user_name = [aDecoder decodeObjectForKey:@"user_name"];
    self.avatar_url = [aDecoder decodeObjectForKey:@"avatar_url"];
    self.desc = [aDecoder decodeObjectForKey:@"desc"];
    self.text = [aDecoder decodeObjectForKey:@"text"];
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"desc"];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@", self.text, self.user_name, self.desc];
}

@end
