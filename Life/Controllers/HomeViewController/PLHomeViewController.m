//
//  PLHomeViewController.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLHomeViewController.h"
#import "PLTableHeaderView.h"
#import "PLHomeLifeCell.h"
#import "PLHomeLifeModel.h"
#import "PLHomeArticalModel.h"
#import "PLHomeArticalCell.h"
#import "PLHomeArticalViewController.h"
#import "PLHomeLifeMiddleViewController.h"

typedef NS_ENUM(NSInteger, refreshStatu){
    refreshStatuMoreData,
    refreshStatuLoadData
};

@interface PLHomeViewController () <PLHomeLifeCollectionProtocol, PLHomeArticalCollectionProtocol> {
    PLTableHeaderView *_headView;
    UIButton *_articalButton;
    UIButton *_lifeButton;
}

@property (nonatomic, assign) NSInteger currectIndex;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSMutableArray *cycleSourceArray;
@property (nonatomic, assign) refreshStatu status;

@end

@implementation PLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //更改导航条名字
    self.navigationItem.title = @"首页";
    
    //创建头视图
    [self plCreateHeaderView];
    
    //添加刷新
    [self addRefreshMoreData];
}

#pragma mark ----创建头视图----
- (void)plCreateHeaderView {
    _headView = [[PLTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 260)];
    self.tableView.tableHeaderView = _headView;
    //注册cell
    [self.tableView registerClass:[PLHomeLifeCell class] forCellReuseIdentifier:@"plHomeLifeCell"];
    
    [self.tableView registerClass:[PLHomeArticalCell class] forCellReuseIdentifier:@"plHomeArticalCell"];
    
    //创建美文按钮
    _articalButton = [FactoryUI plCreateButtonWithFrame:CGRectMake(20 + (_headView.bounds.size.width - 30) / 2.0, _headView.bounds.size.height - 40, (_headView.bounds.size.width - 30) / 2.0, 40) title:@"美  文" titleColor:[UIColor blackColor] imageName:@"" backgroundImageName:nil target:self selector:@selector(plRefreshArticalTableView:)];
    _articalButton.backgroundColor = [UIColor lightGrayColor];
    [_headView addSubview:_articalButton];
    
    //创建生活按钮
    _lifeButton = [FactoryUI plCreateButtonWithFrame:CGRectMake(10, _headView.bounds.size.height - 40, (_headView.bounds.size.width - 30) / 2.0, 40) title:@"生  活" titleColor:[UIColor blackColor] imageName:@"" backgroundImageName:nil target:self selector:@selector(plRefreshLifeTableView:)];
    _lifeButton.selected = YES;
    _lifeButton.backgroundColor = [UIColor redColor];
    [_headView addSubview:_lifeButton];
}

#pragma mark ----刷新数据按钮----
- (void)plRefreshLifeTableView:(UIButton *)btn {
    //
    if (btn.selected == YES) {
        return;
    }
    
    if (self.dataSourceArray.count != 0) {
        [self.dataSourceArray removeAllObjects];
    }
    
    //刷新数据
    if (btn.selected == NO) {
        btn.selected = YES;
        btn.backgroundColor = [UIColor redColor];
        if (_articalButton.selected == YES) {
            _articalButton.selected = NO;
            _articalButton.backgroundColor = [UIColor lightGrayColor];
        }
        
        //请求数据
        _page = 1;
        [self plGetDataWithUrlStr:HOMEURL];
    }
}

- (void)plRefreshArticalTableView:(UIButton *)btn {
    
    if (self.dataSourceArray.count != 0) {
        [self.dataSourceArray removeAllObjects];
    }
    
    //
    if (btn.selected == YES) {
        return;
    }
    
    //刷新数据
    if (btn.selected == NO) {
        btn.selected = YES;
        btn.backgroundColor = [UIColor redColor];
        if (_lifeButton.selected == YES) {
            _lifeButton.selected = NO;
            _lifeButton.backgroundColor = [UIColor lightGrayColor];
        }
        
        //请求数据
        _page = 1;
        [self plGetDataWithUrlStr:ARTICALURL];
    }
}

#pragma mark ----tableView代理-----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_lifeButton.selected == YES) {
        PLHomeLifeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plHomeLifeCell" forIndexPath:indexPath];
        PLHomeLifeModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
        
        //设置属性值
        [cell plRefreshCellWithHomeLifeModel:model];
        
        //添加约束
        [cell addContraninForCell];
        
        return cell;
    }
    
    PLHomeArticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plHomeArticalCell" forIndexPath:indexPath];
    
    PLHomeArticalModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    //设置属性值
    [cell plRefreshCellWithHomeLifeModel:model];
    
    //添加约束
    [cell addContraninForCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //退出选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.currectIndex = indexPath.row;
    
    if (_articalButton.selected == YES) {
        
        //推出文章详情页
        PLHomeArticalViewController *articalVC = [[PLHomeArticalViewController alloc] init];
        articalVC.dataID = ((PLHomeArticalModel *)[self.dataSourceArray objectAtIndex:indexPath.row]).dataID;
        articalVC.navigationItem.title = @"美文";
        articalVC.delegate = self;
        [self plCreateBackBarButtomItem];
        [self.navigationController pushViewController:articalVC animated:YES];
    } else if (_lifeButton.selected == YES) {
        
        //推出生活详情页
        PLHomeLifeMiddleViewController *lifeVC = [[PLHomeLifeMiddleViewController alloc] init];
        lifeVC.navigationItem.title = ((PLHomeLifeModel *)[self.dataSourceArray objectAtIndex:indexPath.row]).title;
        lifeVC.dataID = ((PLHomeLifeModel *)[self.dataSourceArray objectAtIndex:indexPath.row]).dataID;
        lifeVC.delegate = self;
        [self plCreateBackBarButtomItem];
        [self.navigationController pushViewController:lifeVC animated:YES];
    }
}

#pragma mark ----请求数据----
/**
 请求数据
 */
- (void)plGetDataWithUrlStr:(NSString *)urlStr {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (_articalButton.selected == YES) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    
    [manager GET:[NSString stringWithFormat:urlStr, self.page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //处理数据
        if (self.status == refreshStatuLoadData) {
            [self.dataSourceArray removeAllObjects];
        }
        
        //1.为数据源赋值
        if (_lifeButton.selected == YES) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            
            for (NSDictionary *tempDic in [dic objectForKey:@"topic"]) {
                PLHomeLifeModel *model = [[PLHomeLifeModel alloc] init];
                [model setValuesForKeysWithDictionary:tempDic];
                [self.dataSourceArray addObject:model];
            }
            
            //2.为轮播数组赋值
            for (NSDictionary *cycleDic in [dic objectForKey:@"entry_list"]) {
                NSString *tempPic2 = [cycleDic objectForKey:@"pic2"];
                if ([tempPic2 isEqualToString:@""]) {
                    
                } else {
                    [self.cycleSourceArray addObject:tempPic2];
                }
            }
        } else if (_articalButton.selected == YES) {
            //
            NSArray *array = [responseObject objectForKey:@"data"];
            
            //遍历该数组
            for (NSDictionary *dic in array) {
                PLHomeArticalModel *model = [[PLHomeArticalModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataSourceArray addObject:model];
            }
        }
        
        //开始轮播
        if (_headView.urlImageArray.count == 0) {
            _headView.urlImageArray = [NSMutableArray arrayWithArray:self.cycleSourceArray];
            
            //开始轮播
            [_headView plStartAutomaticScrollImage];
        }
        
        
        //刷新数组
        [self.tableView reloadData];
        
        //停止刷新
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //停止刷新
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        
    }];
}

#pragma mark ----刷新相关----
- (void)addRefreshMoreData {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        
        self.status = refreshStatuMoreData;
        
        if (_articalButton.selected == YES) {
            [self plGetDataWithUrlStr:ARTICALURL];
        } else if (_lifeButton.selected == YES) {
            [self plGetDataWithUrlStr:HOMEURL];
        }
        
    }];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        
        self.status = refreshStatuLoadData;
        
        if (_articalButton.selected == YES) {
            [self plGetDataWithUrlStr:ARTICALURL];
        } else if (_lifeButton.selected == YES) {
            [self plGetDataWithUrlStr:HOMEURL];
        }
        
    }];
    
    self.tableView.header = header;
    self.tableView.footer = footer;
    
    [self.tableView.header beginRefreshing];
}

#pragma mark ----收藏相关----
//收藏文章
- (void)plHomeCollectionArtical {
    
    PLHomeArticalModel *model = [self.dataSourceArray objectAtIndex:self.currectIndex];
    /*
     @property (nullable, nonatomic, retain) NSString *dataID;
     @property (nullable, nonatomic, retain) NSString *pic;
     @property (nullable, nonatomic, retain) NSString *title;
     @property (nullable, nonatomic, retain) NSString *author;
     */
    
    PLCoreArticalModel *coreModel = [PLCoreArticalModel MR_createEntity];
    
    coreModel.dataID = model.dataID;
    coreModel.pic = model.pic;
    coreModel.title = model.title;
    coreModel.author = model.author;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

//收藏生活
- (void)plHomeCollectionLife {
    
    PLHomeLifeModel *model = [self.dataSourceArray objectAtIndex:self.currectIndex];
    /*
     @property (nullable, nonatomic, retain) NSString *likes;
     @property (nullable, nonatomic, retain) NSString *dataID;
     @property (nullable, nonatomic, retain) NSString *pic;
     @property (nullable, nonatomic, retain) NSString *title;
     */
    //1.创建实体
    PLCoreLifeModel *coreModel = [PLCoreLifeModel MR_createEntity];
    
    //赋值
    coreModel.likes = model.likes;
    coreModel.dataID = model.dataID;
    coreModel.pic = model.pic;
    coreModel.title = model.title;
    
    //保存本次操作
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)plHomeDisCollectionLife {
    
    PLHomeLifeModel *model = [self.dataSourceArray objectAtIndex:self.currectIndex];
    
    NSArray *array = [PLCoreLifeModel MR_findByAttribute:@"dataID" withValue:model.dataID];
    
    if (array.count == 1) {
        PLCoreLifeModel *coreModel = array.firstObject;
        
        [coreModel MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

- (void)plHomeDisCollectionArtical {
    PLHomeArticalModel *model = [self.dataSourceArray objectAtIndex:self.currectIndex];
    
    NSArray *array = [PLCoreArticalModel MR_findByAttribute:@"dataID" withValue:model.dataID];
    
    if (array.count == 1) {
        PLCoreArticalModel *coreModel = array.firstObject;
        
        [coreModel MR_deleteEntity];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

#pragma mark ---懒加载数组---
- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
}

- (NSMutableArray *)cycleSourceArray {
    if (_cycleSourceArray == nil) {
        _cycleSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cycleSourceArray;
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
