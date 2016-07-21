//
//  PLAmuseViewController.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLAmuseViewController.h"
#import "PLAmuseHomeCell.h"
#import "PLAMuseDetailViewController.h"

@interface PLAmuseViewController ()

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PLAmuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频";
    
    //注册cell
    [self.tableView registerClass:[PLAmuseHomeCell class] forCellReuseIdentifier:@"plAmuseHomeCell"];
    
    //加载数据
    [self plLoadDataWithHomeAmuse];
}

#pragma mark ----tableView代理-----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)[self.dataArray objectAtIndex:section]).count / 3.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PLAmuseHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plAmuseHomeCell" forIndexPath:indexPath];
    
    [cell addContraninForCell];

    NSInteger count = ((NSArray *)[self.dataArray objectAtIndex:indexPath.section]).count;
    
    PLAmuseHomeModel *modelOne = nil;
    PLAmuseHomeModel *modelTwo = nil;
    PLAmuseHomeModel *modelThree = nil;
    
    for (NSInteger i = 0; i < 3; i++) {
        if (indexPath.row * 3 + i < count) {
            switch (i) {
                case 0:
                    modelOne = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row * 3 + i];
                    break;
                    
                case 1:
                    modelTwo = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row * 3 + i];
                    break;
                    
                case 2:
                    modelThree = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row * 3 + i];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    [cell plRefreshCellWithHomeLifeModelOne:modelOne ModelTwo:modelTwo ModelThree:modelThree];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.titleArray objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PLAMuseDetailViewController *detailVC = [[PLAMuseDetailViewController alloc] init];
    NSString *tempStr = [self.titleArray objectAtIndex:indexPath.section];
    
    if ([tempStr isEqualToString:@"电影"]) {
        detailVC.url = AMUSEMOVIE;
    } else if ([tempStr isEqualToString:@"电视剧"]) {
        detailVC.url = AMUSETV;
    } else if ([tempStr isEqualToString:@"微电影"]) {
        detailVC.url = AMUSESMALLMOVIE;
    } else if ([tempStr isEqualToString:@"综艺"]) {
        detailVC.url = AMUSEVARIETYSHOW;
    } else if ([tempStr isEqualToString:@"动漫"]) {
        detailVC.url = AMUSEANIMATION;
    } else {
        
    }
    
    detailVC.title = tempStr;
    [self.navigationController pushViewController:detailVC animated:NO];
    
    [self plCreateBackBarButtomItem];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [FactoryUI plCreateViewWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    view.backgroundColor = [UIColor lightTextColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(plBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 2, SCREEN_W - 20, 26);
    button.layer.cornerRadius = 5;
    button.tag = 10 + section;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1;
    [button setTitle:[NSString stringWithFormat:@"点击进入获取更多的%@", [self.titleArray objectAtIndex:section]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:button];
    
    return view;
}


- (void)plBtnAction:(UIButton *)btn {
    
    PLAMuseDetailViewController *detailVC = [[PLAMuseDetailViewController alloc] init];
    NSString *tempStr = [self.titleArray objectAtIndex:btn.tag - 10];
    
    if ([tempStr isEqualToString:@"电影"]) {
        detailVC.url = AMUSEMOVIE;
    } else if ([tempStr isEqualToString:@"电视剧"]) {
        detailVC.url = AMUSETV;
    } else if ([tempStr isEqualToString:@"微电影"]) {
        detailVC.url = AMUSESMALLMOVIE;
    } else if ([tempStr isEqualToString:@"综艺"]) {
        detailVC.url = AMUSEVARIETYSHOW;
    } else if ([tempStr isEqualToString:@"动漫"]) {
        detailVC.url = AMUSEANIMATION;
    } else {
        
    }
    
    detailVC.title = tempStr;
    [self.navigationController pushViewController:detailVC animated:NO];
    
    [self plCreateBackBarButtomItem];
}

#pragma mark ---加载数据---
- (void)plLoadDataWithHomeAmuse {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-javascript"];
    
    [manager GET:AMUSERECOMMEND parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //处理数据
        NSArray *rootArray = [responseObject objectForKey:@"slices"];
        
        for (NSDictionary *tempDic in rootArray) {
            if ([[tempDic objectForKey:@"name"] isEqualToString:@"电影"] || [[tempDic objectForKey:@"name"] isEqualToString:@"电视剧"] || [[tempDic objectForKey:@"name"] isEqualToString:@"微电影"] || [[tempDic objectForKey:@"name"] isEqualToString:@"综艺"] || [[tempDic objectForKey:@"name"] isEqualToString:@"动漫"]) {
                
                NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
                
                for (NSDictionary *movieDic in [tempDic objectForKey:@"hot"]) {
                    PLAmuseHomeModel *model = [[PLAmuseHomeModel alloc] init];
                    [model setValuesForKeysWithDictionary:movieDic];
                    [tempArray addObject:model];
                }
                
                [self.dataArray addObject:tempArray];
                [self.titleArray addObject:[tempDic objectForKey:@"name"]];
            }
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        NSLog(@"%@", error);
    }];
}


#pragma mark ---懒加载---
- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _titleArray;
}

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
