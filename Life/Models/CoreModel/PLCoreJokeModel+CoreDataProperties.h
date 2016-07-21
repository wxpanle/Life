//
//  PLCoreJokeModel+CoreDataProperties.h
//  Life
//
//  Created by qianfeng on 16/6/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PLCoreJokeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLCoreJokeModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *avatar_url;
@property (nullable, nonatomic, retain) NSNumber *comment_count;
@property (nullable, nonatomic, retain) id commentArray;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSNumber *dataID;
@property (nullable, nonatomic, retain) NSNumber *favorite_count;
@property (nullable, nonatomic, retain) NSNumber *share_count;
@property (nullable, nonatomic, retain) NSString *share_url;
@property (nullable, nonatomic, retain) NSString *userName;

@end

NS_ASSUME_NONNULL_END
