//
//  PLFoodViewController.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLJokeViewController.h"
#import "PLJokeModel.h"
#import "PLJokeCell.h"
#import "PLJokeCommentModel.h"
#import "PLJokeCommentCell.h"
#import "PLJokeCommentViewController.h"

//上拉刷新或者下拉加载判断
typedef NS_ENUM(NSInteger, refreshStatus) {
    refreshStatusMoreData,
    refreshStatusLoadData
};

////加载数据或者评论
//typedef NS_ENUM(NSInteger, refreshStatusOfComment) {
//    refreshStatusOfCommentMoreData,
//    refreshStatusOfCommentNormal
//};

@interface PLJokeViewController () <PLJokeCellShareProtocol>

//数据源
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

//是否展开
@property (nonatomic, strong) NSMutableArray *isSpreadArray;

//状态
@property (nonatomic, assign) refreshStatus status;

//评论的状态
//@property (nonatomic, assign) refreshStatusOfComment statusComment;

@end

@implementation PLJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"搞笑段子";
    
    [self.tableView registerClass:[PLJokeCell class] forCellReuseIdentifier:@"plJokeCell"];
    
    [self.tableView registerClass:[PLJokeCommentCell class] forCellReuseIdentifier:@"plJokeCommentCell"];
    
    //加载数据
    [self plGetDataWithDate:JOKEDATA];
    
    //添加刷新
    [self plAddRefresh];
}

#pragma mark ----视图即将出现----
- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark ----tableView----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PLJokeModel *model = [self.dataSourceArray objectAtIndex:section];
    return 1 + model.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PLJokeModel *model = [self.dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        PLJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plJokeCell" forIndexPath:indexPath];
        
        NSInteger index = indexPath.section;
        [cell addContraninForCell];
        
        [cell plRefreshCellWithHomeLifeModel:model andIndex:index];
        
        cell.jokeDelegate = self;
        
        return cell;
    }
    
    PLJokeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plJokeCommentCell" forIndexPath:indexPath];
    PLJokeCommentModel *commentModel = [model.commentArray objectAtIndex:indexPath.row - 1];
    [cell plRefreshCellWithHomeLifeModel:commentModel];
    [cell addContraninForCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark ----请求数据----
- (void)plGetDataWithDate:(NSString *)date {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:date parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //添加数据
        NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"data"];
    
        for (NSDictionary *dic in array) {
            
            PLJokeModel *model = [[PLJokeModel alloc] init];
            [model setValuesForKeysWithDictionary:[dic objectForKey:@"group"]];
            model.userName = [[[dic objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"name"];
            model.avatar_url = [[[dic objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"avatar_url"];
            for (NSDictionary *commentDic in [dic objectForKey:@"comments"]) {
                PLJokeCommentModel *commentModel = [[PLJokeCommentModel alloc] init];
                [commentModel setValuesForKeysWithDictionary:commentDic];
                [model.commentArray addObject:commentModel];
            }
            
            [self.isSpreadArray addObject:@(NO)];
            [self.dataSourceArray addObject:model];
        
        }
        
        //刷新tableView
        [self.tableView reloadData];
        
        //
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        
    }];
}

#pragma mark ----添加上拉加载数据----

- (void)plAddRefresh {
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        //刷新时间
        NSDate *systemDate = [NSDate date];
        
        //返回某个时间距离现在多少秒
        NSTimeInterval time = [systemDate timeIntervalSinceNow];
        
        //设置状态
        self.status = refreshStatusMoreData;
        
        [self plGetMoreDataWithDate:[NSString stringWithFormat:@"%f",time]];
        
    }];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时间
        NSDate *systemDate = [NSDate date];
        
        //返回某个时间距离现在多少秒
        NSTimeInterval time = [systemDate timeIntervalSinceNow];
        
        self.status = refreshStatusLoadData;
        
        [self plGetMoreDataWithDate:[NSString stringWithFormat:@"%f",time]];
    }];
    
    self.tableView.footer = footer;
    self.tableView.header = header;
    
}

/**
 请求更多的数据
 */
- (void)plGetMoreDataWithDate:(NSString *)date {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:JokeMoreData,date] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //添加数据
        NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"data"];
        
        if (self.status == refreshStatusLoadData) {
            [self.dataSourceArray removeAllObjects];
        }
        
        for (NSDictionary *dic in array) {
            
            PLJokeModel *model = [[PLJokeModel alloc] init];
            [model setValuesForKeysWithDictionary:[dic objectForKey:@"group"]];
            model.userName = [[[dic objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"name"];
            model.avatar_url = [[[dic objectForKey:@"group"] objectForKey:@"user"] objectForKey:@"avatar_url"];
            for (NSDictionary *commentDic in [dic objectForKey:@"comments"]) {
                PLJokeCommentModel *commentModel = [[PLJokeCommentModel alloc] init];
                [commentModel setValuesForKeysWithDictionary:commentDic];
                [model.commentArray addObject:commentModel];
                
                [self.isSpreadArray addObject:@(NO)];
            }
            
            [self.dataSourceArray addObject:model];
        }
        
        //刷新tableView
        [self.tableView reloadData];
        
        //
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
    }];
}


#pragma mark ----分享段子----
- (void)plShareJokeWithIndex:(NSInteger)index {
    
    PLJokeModel *model = [self.dataSourceArray objectAtIndex:index];
    
    //分享
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5729571567e58e414b0003e5" shareText:model.share_url shareImage:nil shareToSnsNames:@[UMShareToQQ, UMShareToQzone, UMShareToSina] delegate:nil];
}

#pragma mark ----加载更多评论----
- (void)plCommentJokeWithIndex:(NSInteger)index {
    
    //拿到模型
    PLJokeModel *model = [self.dataSourceArray objectAtIndex:index];
    
    //推出下一个视图
    PLJokeCommentViewController *commentVC = [[PLJokeCommentViewController alloc] init];
    commentVC.model = model;
    [self.navigationController pushViewController:commentVC animated:YES];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    commentVC.navigationItem.backBarButtonItem = backItem;
}

#pragma mark ----收藏----
- (void)plCommentJokeCollectionWithIndex:(NSInteger)index {
    PLJokeModel *model = [self.dataSourceArray objectAtIndex:index];
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
    
    coreModel.content = model.content;
    coreModel.userName = model.userName;
    coreModel.avatar_url = model.avatar_url;
    coreModel.comment_count = model.comment_count;
    coreModel.share_count = model.share_count;
    coreModel.favorite_count = model.favorite_count;
    coreModel.share_url = model.share_url;
    coreModel.dataID = model.ID;
    coreModel.commentArray = model.commentArray;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.tableView reloadData];
}

/**
 取消收藏
 */
- (void)plCommentJokeDisCollectionWithIndex:(NSInteger)index {
    PLJokeModel *model = [self.dataSourceArray objectAtIndex:index];
    
    NSArray *array = [PLCoreJokeModel MR_findByAttribute:@"dataID" withValue:model.ID];
    
    if (array.count == 1) {
        PLCoreJokeModel *coreModel = array.firstObject;
        
        [coreModel MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self.tableView reloadData];
    }
}

#pragma mark ----懒加载----
- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
}

- (NSMutableArray *)isSpreadArray {
    if (_isSpreadArray == nil) {
        _isSpreadArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _isSpreadArray;
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
