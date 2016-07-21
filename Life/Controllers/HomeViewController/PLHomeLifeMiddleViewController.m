//
//  PLHomeViewController.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLHomeLifeMiddleViewController.h"
#import "PLHomeMiddleLifeModel.h"
#import "PLLifeDetailCell.h"

@interface PLHomeLifeMiddleViewController () {
    UIImageView *_imageView;
    UIButton *_collectButton;
}
  
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation PLHomeLifeMiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建头视图
    [self plCreateHeaderView];
    
    //加载数据
    [self plGetDataWithUrlStr];
    
    //改变收藏按钮的状态
    [self plSearchCoreDataToSwitchCollectionButtonState];
}

#pragma mark ----创建头视图----
- (void)plCreateHeaderView {

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 200)];
    
    self.tableView.tableHeaderView = _imageView;
    
    //注册cell
    [self.tableView registerClass:[PLLifeDetailCell class] forCellReuseIdentifier:@"plLifeDetailCell"];
    
    //收藏按钮
    _collectButton = [FactoryUI plCreateButtonWithFrame:CGRectMake(SCREEN_W - 50, 40, 40, 40) title:nil titleColor:nil imageName:@"Home_Detail_Collection" backgroundImageName:nil target:self selector:@selector(collectionButtonClick:)];
    [_collectButton setImage:[UIImage imageNamed:@"Home_Detail_Collection-2"] forState:UIControlStateSelected];
    [self.view addSubview:_collectButton];
    
}

#pragma mark ----分享和收藏相关----

- (void)collectionButtonClick:(UIButton *)button {
    
    if (_collectButton.selected == NO) {
        _collectButton.selected = YES;
        [self.delegate plHomeCollectionLife];
    } else if (_collectButton.selected == YES) {
        _collectButton.selected = NO;
        [self.delegate plHomeDisCollectionLife];
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
    
    PLLifeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plLifeDetailCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[PLLifeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"plLifeDetailCell"];
    }
    
    PLHomeMiddleLifeModel *model = [[PLHomeMiddleLifeModel alloc] init];
    model = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [cell plRefreshCellWithHomeLifeModel:model];
    
    [cell addContraninForCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 }

#pragma mark ----请求数据----
/**
 请求数据
 */
- (void)plGetDataWithUrlStr {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:HOMEDETAIL,self.dataID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //为数据源赋值
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        for (NSDictionary *dic in [dict objectForKey:@"product"]) {
            PLHomeMiddleLifeModel *model = [[PLHomeMiddleLifeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSourceArray addObject:model];
        }
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"data"] objectForKey:@"pic"]]];
        
        //刷新数据
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self plGetDataWithUrlStr];
        
    }];
}

#pragma mark ----收藏状态按钮状态----
- (void)plSearchCoreDataToSwitchCollectionButtonState {
    
    //查找本地数据可看有没有收藏
    NSArray *array = [PLCoreLifeModel MR_findByAttribute:@"dataID" withValue:self.dataID];
    
    if (array.count == 1) {
        _collectButton.selected = YES;
    } else {
        _collectButton.selected = NO;
    }
}

#pragma mark ---懒加载数组---
- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
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
