//
//  PLHomeArticalModel.m
//  Life
//
//  Created by qianfeng on 16/5/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLHomeArticalModel.h"

@implementation PLHomeArticalModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"dataID"];
    }
}

@end
