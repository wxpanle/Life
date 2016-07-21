//
//  PLAMuseDetailViewController.m
//  Life
//
//  Created by qianfeng on 16/5/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLAMuseDetailViewController.h"
#import "PLAmuseLayoutCell.h"

typedef NS_ENUM(NSInteger, refreshStatus){
    refreshStatusMoreData,
    refreshStatusLoadData
};

@interface PLAMuseDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int begPage;
@property (nonatomic, assign) int endPage;
@property (nonatomic, assign) refreshStatus status;

@end

@implementation PLAMuseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建网格视图
    [self plCreateCollectionView];
    
    self.begPage = 0;
    self.endPage = 10;
    
    //添加刷新
    [self plLoadData];
    
    //添加刷新控件
    [self addRefreshUI];
}

#pragma mark ---创建collectionView---
- (void)plCreateCollectionView {
    //创建网格布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_W / 2 - 20, (SCREEN_W / 2 - 20) * 4 / 3 + 50);
    flowLayout.minimumLineSpacing = 10.0f;
    flowLayout.minimumInteritemSpacing = 20.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[PLAmuseLayoutCell class] forCellWithReuseIdentifier:@"plAmuseLayoutCell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
}

#pragma mark ---collectionView----

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PLAmuseLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"plAmuseLayoutCell" forIndexPath:indexPath];
    
    [cell addContraninForCell];
    
    PLAmuseModel *model = [self.dataArray objectAtIndex:indexPath.item];
    
    [cell plRefreshCellWithHomeLifeModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"sorry" message:@"这里只提供搜索,不提供播放哦" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancel];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)addRefreshUI {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.begPage = self.endPage;
        self.endPage += 10;
        self.status = refreshStatusMoreData;
        
        [self plLoadData];
    }];
    
    _collectionView.footer = footer;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.begPage = 0;
        self.endPage = 10;
        self.status = refreshStatusLoadData;
        
        [self plLoadData];
    }];
    
    _collectionView.header = header;
}

- (void)plLoadData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-javascript"];
    
    [manager GET:[NSString stringWithFormat:self.url, self.begPage, self.endPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *rootDic = [responseObject objectForKey:@"video_list"];
        
        if (self.status == refreshStatusLoadData) {
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *tempDic in [rootDic objectForKey:@"videos"]) {
            PLAmuseModel *model = [[PLAmuseModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.dataArray addObject:model];
        }
        
        if ([_collectionView.footer isRefreshing]) {
            [_collectionView.footer endRefreshing];
        }
        
        if ([_collectionView.header isRefreshing]) {
            [_collectionView.header endRefreshing];
        }
        
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        self.begPage = self.begPage - 10;
        self.endPage -= 10;
        if ([_collectionView.footer isRefreshing]) {
            [_collectionView.footer endRefreshing];
        }
        
        if ([_collectionView.header isRefreshing]) {
            [_collectionView.header endRefreshing];
        }
    }];
}

#pragma mark ---懒加载---
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
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
