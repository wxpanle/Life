//
//  PLCoreLifeModel+CoreDataProperties.h
//  Life
//
//  Created by qianfeng on 16/6/1.
//  Copyright © 2016年 qianfeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PLCoreLifeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLCoreLifeModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *likes;
@property (nullable, nonatomic, retain) NSString *dataID;
@property (nullable, nonatomic, retain) NSString *pic;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
