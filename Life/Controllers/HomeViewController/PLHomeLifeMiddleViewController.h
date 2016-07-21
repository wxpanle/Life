//
//  PLHomeLifeMiddleViewController.h
//  Life
//
//  Created by qianfeng on 16/5/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLBaseViewController.h"

@protocol PLHomeLifeCollectionProtocol <NSObject>

- (void)plHomeCollectionLife;

- (void)plHomeDisCollectionLife;

@end

@interface PLHomeLifeMiddleViewController : PLBaseViewController

@property (nonatomic, weak) id <PLHomeLifeCollectionProtocol> delegate;

@property (nonatomic, copy) NSString *dataID;

@end
