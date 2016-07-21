//
//  PLMyCollectViewController.m
//  Life
//
//  Created by qianfeng on 16/6/1.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLMyCollectViewController.h"
#import "PLHomeLifeCell.h"
#import "PLHomeLifeModel.h"
#import "PLHomeArticalModel.h"
#import "PLHomeArticalCell.h"
#import "PLJokeModel.h"
#import "PLJokeCell.h"
#import "PLJokeCommentModel.h"
#import "PLJokeCommentCell.h"
#import "PLJokeCommentViewController.h"
#import "PLHomeArticalViewController.h"
#import "PLHomeLifeMiddleViewController.h"


@interface PLMyCollectViewController () <PLJokeCellShareProtocol>

@property (nonatomic, strong) NSMutableArray *lifeDataArray;
@property (nonatomic, strong) NSMutableArray *articalDataArray;
@property (nonatomic, strong) NSMutableArray *jokeDataArray;

@end

@implementation PLMyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //为tableView添加相关属性
    [self plAddTableViewAttribute];
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.lifeDataArray.count != 0) {
        [self.lifeDataArray removeAllObjects];
    }
    
    if (self.articalDataArray.count != 0) {
        [self.articalDataArray removeAllObjects];
    }
    
    if (self.jokeDataArray.count != 0) {
        [self.jokeDataArray removeAllObjects];
    }
    //查找数据库为各个数组赋值
    [self plSearchToGetModel];
    
    [self.tableView reloadData];
}

#pragma mark ----tableView----
- (void)plAddTableViewAttribute {
    
    //注册cell
    [self.tableView registerClass:[PLHomeLifeCell class] forCellReuseIdentifier:@"plHomeLifeCell"];

    [self.tableView registerClass:[PLHomeArticalCell class] forCellReuseIdentifier:@"plHomeArticalCell"];
    
    [self.tableView registerClass:[PLJokeCell class] forCellReuseIdentifier:@"plJokeCell"];
    
    [self.tableView registerClass:[PLJokeCommentCell class] forCellReuseIdentifier:@"plJokeCommentCell"];
}


#pragma mark ----tableView相关----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.lifeDataArray.count;
    }
    
    if (section == 1) {
        return self.articalDataArray.count;
    }
    
    return self.jokeDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PLHomeLifeCell *lifeCell = [tableView dequeueReusableCellWithIdentifier:@"plHomeLifeCell" forIndexPath:indexPath];
        
        PLHomeLifeModel *lifeModel = [self.lifeDataArray objectAtIndex:indexPath.row];
        
        [lifeCell addContraninForCell];
        
        [lifeCell plRefreshCellWithHomeLifeModel:lifeModel];
        
        return lifeCell;
    }
    
    if (indexPath.section == 1) {
        PLHomeArticalModel *articalModel = [self.articalDataArray objectAtIndex:indexPath.row];
        
        PLHomeArticalCell *articalCell = [tableView dequeueReusableCellWithIdentifier:@"plHomeArticalCell" forIndexPath:indexPath];
        
        [articalCell addContraninForCell];
        
        [articalCell plRefreshCellWithHomeLifeModel:articalModel];
        
        return articalCell;
    }
    
    PLJokeModel *jokeModel = [self.jokeDataArray objectAtIndex:indexPath.row];
    
    PLJokeCell *jokeCell = [tableView dequeueReusableCellWithIdentifier:@"plJokeCell" forIndexPath:indexPath];
    
    [jokeCell addContraninForCell];
    
    jokeCell.jokeDelegate = self;
    
    jokeCell.collectButton.hidden = YES;
    
    [jokeCell plRefreshCellWithHomeLifeModel:jokeModel andIndex:indexPath.row];
    
    return jokeCell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"生活";
    }
    
    if (section == 1) {
        return @"美文";
    }
    
    return @"段子";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        //推出文章详情页
        PLHomeArticalViewController *articalVC = [[PLHomeArticalViewController alloc] init];
        articalVC.dataID = ((PLHomeArticalModel *)[self.articalDataArray objectAtIndex:indexPath.row]).dataID;
        articalVC.navigationItem.title = @"美文";
        [self plCreateBackBarButtomItem];
        [self.navigationController pushViewController:articalVC animated:YES];
        
    } else if (indexPath.section == 0) {
        
        //推出生活详情页
        PLHomeLifeMiddleViewController *lifeVC = [[PLHomeLifeMiddleViewController alloc] init];
        lifeVC.navigationItem.title = ((PLHomeLifeModel *)[self.lifeDataArray objectAtIndex:indexPath.row]).title;
        lifeVC.dataID = ((PLHomeLifeModel *)[self.lifeDataArray objectAtIndex:indexPath.row]).dataID;
        [self plCreateBackBarButtomItem];
        [self.navigationController pushViewController:lifeVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PLHomeLifeModel *model = [self.lifeDataArray objectAtIndex:indexPath.row];
        
        PLCoreLifeModel *coreModel = [PLCoreLifeModel MR_findByAttribute:@"dataID" withValue:model.dataID].firstObject;
        
        [coreModel MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self.lifeDataArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
    }
    
    if (indexPath.section == 1) {
        
        PLHomeArticalModel *model = [self.articalDataArray objectAtIndex:indexPath.row];
        
        PLCoreArticalModel *coreModel = [PLCoreArticalModel MR_findByAttribute:@"dataID" withValue:model.dataID].firstObject;
        
        [coreModel MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self.articalDataArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
        
    }
    
    if (indexPath.section == 2) {
        PLJokeModel *model = [self.jokeDataArray objectAtIndex:indexPath.row];
        
        PLCoreJokeModel *coreModel = [PLCoreJokeModel MR_findByAttribute:@"dataID" withValue:model.ID].firstObject;
        
        [coreModel MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self.jokeDataArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
#pragma mark ----为数组赋值----
- (void)plSearchToGetModel {
    /*
     @property (nullable, nonatomic, retain) NSString *likes;
     @property (nullable, nonatomic, retain) NSString *dataID;
     @property (nullable, nonatomic, retain) NSString *pic;
     @property (nullable, nonatomic, retain) NSString *title;
     */
    //为生活数组赋值
    NSArray *lifeArray = [PLCoreLifeModel MR_findAll];
    
    for (PLCoreLifeModel *lifeModel in lifeArray) {
        
        PLHomeLifeModel *model = [[PLHomeLifeModel alloc] init];
        model.likes = lifeModel.likes;
        model.dataID = lifeModel.dataID;
        model.pic = lifeModel.pic;
        model.title = lifeModel.title;
        
        [self.lifeDataArray addObject:model];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    /*
     @property (nullable, nonatomic, retain) NSString *dataID;
     @property (nullable, nonatomic, retain) NSString *pic;
     @property (nullable, nonatomic, retain) NSString *title;
     @property (nullable, nonatomic, retain) NSString *author;
     */
    //为美文数组赋值
    NSArray *articalArray = [PLCoreArticalModel MR_findAll];
    
    for (PLCoreArticalModel *articalModel in articalArray) {
        
        PLHomeArticalModel *model = [[PLHomeArticalModel alloc] init];
        model.dataID = articalModel.dataID;
        model.pic = articalModel.pic;
        model.title = articalModel.title;
        model.author = articalModel.author;
        
        [self.articalDataArray addObject:model];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
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
    //为段子数组赋值
    NSArray *jokeArray = [PLCoreJokeModel MR_findAll];
    
    for (PLCoreJokeModel *jokeModel in jokeArray) {
        
        PLJokeModel *model = [[PLJokeModel alloc] init];
        model.content = jokeModel.content;
        model.userName = jokeModel.userName;
        model.avatar_url = jokeModel.avatar_url;
        model.comment_count = jokeModel.comment_count;
        model.share_count = jokeModel.share_count;
        model.favorite_count = jokeModel.favorite_count;
        model.share_url = jokeModel.share_url;
        model.ID = jokeModel.dataID;
        model.commentArray = jokeModel.commentArray;
        
        [self.jokeDataArray addObject:model];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}

#pragma mark ----加载更多评论----
- (void)plCommentJokeWithIndex:(NSInteger)index {
    
    //拿到模型
    PLJokeModel *model = [self.jokeDataArray objectAtIndex:index];
    
    //推出下一个视图
    PLJokeCommentViewController *commentVC = [[PLJokeCommentViewController alloc] init];
    commentVC.model = model;
    [self.navigationController pushViewController:commentVC animated:YES];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    commentVC.navigationItem.backBarButtonItem = backItem;
}

#pragma mark ----懒加载----
- (NSMutableArray *)lifeDataArray {
    if (_lifeDataArray == nil) {
        _lifeDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _lifeDataArray;
}

- (NSMutableArray *)articalDataArray {
    if (_articalDataArray == nil) {
        _articalDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _articalDataArray;
}

- (NSMutableArray *)jokeDataArray {
    if (_jokeDataArray == nil) {
        _jokeDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _jokeDataArray;
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
