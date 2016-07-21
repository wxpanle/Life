//
//  PLHomeArticalViewController.m
//  Life
//
//  Created by qianfeng on 16/5/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLHomeArticalViewController.h"

@interface PLHomeArticalViewController ()

@end

@implementation PLHomeArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self plSearchCoreDataToSwitchCollectionButtonState];
}

- (void)collectionButtonClick:(UIButton *)button {
    
    
    if (self.collectButton.selected == NO) {
        
        self.collectButton.selected = YES;
        [self.delegate plHomeCollectionArtical];
        
    } else if (self.collectButton.selected == YES) {
        
        self.collectButton.selected = NO;
        [self.delegate plHomeDisCollectionArtical];
    }
}

#pragma mark ----收藏状态按钮状态----
- (void)plSearchCoreDataToSwitchCollectionButtonState {
    
    //查找本地数据库看有没有收藏
    NSArray *array = [PLCoreArticalModel MR_findByAttribute:@"dataID" withValue:self.dataID];
    
    if (array.count == 1) {
        self.collectButton.selected = YES;
    } else {
        self.collectButton.selected = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
