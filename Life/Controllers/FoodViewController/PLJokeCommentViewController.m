//
//  PLJokeCommentViewController.m
//  Life
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLJokeCommentViewController.h"
#import "PLJokeCell.h"
#import "PLJokeCommentCell.h"

@interface PLJokeCommentViewController () <PLJokeCellShareProtocol>

@end

@implementation PLJokeCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    
    [self.tableView registerClass:[PLJokeCell class] forCellReuseIdentifier:@"plJokeCell"];
    
    [self.tableView registerClass:[PLJokeCommentCell class] forCellReuseIdentifier:@"plJokeCommentCell"];
    
    //加载数据
    [self plGetDataWithDate];
    
    //添加刷新
    [self plAddRefresh];
}
#pragma mark ---tableView---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.commentArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        PLJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plJokeCell" forIndexPath:indexPath];
        
        NSInteger index = indexPath.section;
        
        [cell plRefreshCellWithHomeLifeModel:self.model andIndex:index];
        [cell addContraninForCell];
        
        cell.jokeDelegate = self;
        
        return cell;
    }
    
    PLJokeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plJokeCommentCell" forIndexPath:indexPath];
    PLJokeCommentModel *commentModel = [self.model.commentArray objectAtIndex:indexPath.row - 1];
    [cell plRefreshCellWithHomeLifeModel:commentModel];
    [cell addContraninForCell];
    cell.titelLabel.hidden = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //退出选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark ---刷新---
- (void)plAddRefresh {

    //下拉加载更多
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self plGetDataWithDate];
    }];
    
    self.tableView.footer = footer;
}

- (void)plGetDataWithDate {
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:JokeDataComment, self.model.ID, 20] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tempArray = [[responseObject objectForKey:@"data"] objectForKey:@"recent_comments"];
        
        if (tempArray.count != 0) {
            for (NSDictionary *commentDic in tempArray) {
                PLJokeCommentModel *commentModel = [[PLJokeCommentModel alloc] init];
                [commentModel setValuesForKeysWithDictionary:commentDic];
                [self.model.commentArray addObject:commentModel];
            }
        }
        
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
    }];
}

#pragma mark ----收藏-----
- (void)plCommentJokeCollectionWithIndex:(NSInteger)index {
    /*
     @property (nullable, nonatomic, retain) NSString *content;
     @property (nullable, nonatomic, retain) NSString *userName;
     @property (nullable, nonatomic, retain) NSString *avatar_url;
     @property (nullable, nonatomic, retain) NSNumber *comment_count;
     @property (nullable, nonatomic, retain) NSNumber *share_count;
     @property (nullable, nonatomic, retain) NSNumber *favorite_count;
     @property (nullable, nonatomic, retain) NSString *share_url;
     @property (nullable, nonatomic, retain) NSNumber *dataID;
     @property (nullable, nonatomic, retain) id commentArray;
     */
    PLCoreJokeModel *coreModel = [PLCoreJokeModel MR_createEntity];
    
    coreModel.content = self.model.content;
    coreModel.userName = self.model.userName;
    coreModel.avatar_url = self.model.avatar_url;
    coreModel.comment_count = self.model.comment_count;
    coreModel.share_count = self.model.share_count;
    coreModel.favorite_count = self.model.favorite_count;
    coreModel.share_url = self.model.share_url;
    coreModel.dataID = self.model.ID;
    coreModel.commentArray = self.model.commentArray;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

/**
 取消收藏
 */
- (void)plCommentJokeDisCollectionWithIndex:(NSInteger)index {
    NSArray *array = [PLCoreJokeModel MR_findByAttribute:@"dataID" withValue:self.model.ID];
    
    if (array.count == 1) {
        PLCoreJokeModel *coreModel = array.firstObject;
        
        [coreModel MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

#pragma mark ----分享段子----
- (void)plShareJokeWithIndex:(NSInteger)index {
    
    //分享
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5729571567e58e414b0003e5" shareText:self.model.share_url shareImage:nil shareToSnsNames:@[UMShareToQQ, UMShareToQzone, UMShareToSina] delegate:nil];
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
