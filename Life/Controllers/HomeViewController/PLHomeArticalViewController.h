//
//  PLHomeArticalViewController.h
//  Life
//
//  Created by qianfeng on 16/5/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLWebBaseViewController.h"

@protocol PLHomeArticalCollectionProtocol <NSObject>

- (void)plHomeCollectionArtical;

- (void)plHomeDisCollectionArtical;

@end

@interface PLHomeArticalViewController : PLWebBaseViewController

@property (nonatomic, weak) id <PLHomeArticalCollectionProtocol> delegate;

@end
