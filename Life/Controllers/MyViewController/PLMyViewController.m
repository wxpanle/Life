//
//  PLMyViewController.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLMyViewController.h"
#import "AppDelegate.h"
#import "PLMyCollectViewController.h"

static CGFloat imageHeadHeight = 200;

@interface PLMyViewController () {
    UIImageView *_headImageView;
    UIView *_darkView;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *logoArray;

@end

@implementation PLMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加tableView相关属性
    [self plAddTableViewHead];
}

#pragma maek ----头视图----
- (void)plAddTableViewHead {
    _headImageView = [FactoryUI plCreateImageViewWithFrame:CGRectMake(0, -imageHeadHeight, SCREEN_W, imageHeadHeight) imageName:@"my_head.jpg"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(imageHeadHeight, 0, 0, 0);
    
    [self.tableView addSubview:_headImageView];
}

#pragma mark ---tableView---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseid = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:reuseid];
        
        //加尾巴
        if (indexPath.row == 0 || indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        //添加switch
        if (indexPath.row == 2) {
            //创建switch
            UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_W - 50 , 5, 40, 34)];

            //设置打开时的颜色
            swi.onTintColor = [UIColor cyanColor];
            [swi addTarget:self action:@selector(plSwitchChangeValue:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:swi];
        }
    }
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.logoArray objectAtIndex:indexPath.row]];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        [self plPushAlertWithClearCache];
    }
    
    if (indexPath.row == 0) {
        
        PLMyCollectViewController *collectVC = [[PLMyCollectViewController alloc] init];
        
        collectVC.navigationItem.title = @"收藏";
        
        [self.navigationController pushViewController:collectVC animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //纵向偏移量
    float yOffset = scrollView.contentOffset.y;
    
    //横向偏移量
    float xOffset = (yOffset + imageHeadHeight) / 2;
    
    if (yOffset < -imageHeadHeight) {
        CGRect frame = _headImageView.frame;
        
        //横向偏移量
        frame.origin.x = xOffset;
        
        //纵向偏移量
        frame.origin.y = yOffset;
        
        //宽度
        frame.size.width = SCREEN_W + fabsf(xOffset) * 2;
        
        //高度
        frame.size.height = -yOffset;
        
        _headImageView.frame = frame;
    }
}

#pragma mark ----夜景模式---
- (void)plSwitchChangeValue:(UISwitch *)swi {
    if (swi.on) {
        _darkView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _darkView.userInteractionEnabled = NO;
        //拿到单例
        UIApplication *application = [UIApplication sharedApplication];
        AppDelegate *delegate = application.delegate;
        
        [delegate.window addSubview:_darkView];
    } else {
        [_darkView removeFromSuperview];
    }
}

#pragma mark ----警告框----
/**
 弹出警告框
 */
- (void)plPushAlertWithClearCache {
    
    CGFloat fileSize = [self plCalculateCachesSize];
    UIAlertController *alert = nil;
    
    if (fileSize <= 0.01) {
        //警告框
        alert = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"很干净了" preferredStyle:UIAlertControllerStyleAlert];
    } else {
        //警告框
        alert = [UIAlertController alertControllerWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"当前共有%.2fM缓存",fileSize] preferredStyle:UIAlertControllerStyleAlert];
    }
    
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //清理
    UIAlertAction *clearAction = nil;
    
    if (fileSize <= 0.01) {
        clearAction = [UIAlertAction actionWithTitle:@"很干净了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
    } else {
        clearAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //清理缓存
            [self plClearCache];
            
        }];
    }
    
    
    //添加活动
    [alert addAction:cancelAction];
    [alert addAction:clearAction];
    
    //推出警告框
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ----计算缓存----
/**
 获取缓存的路径
 */
- (NSString *)plGetCacheFilePath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}

/**
 计算缓存的大小
 */
- (CGFloat)plCalculateCachesSize {
    NSString *path = [self plGetCacheFilePath];
    
    //获取文件夹管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    CGFloat returnFileSize = 0.0f;
    
    //判断文件夹是否存在
    if ([manager fileExistsAtPath:path]) {
        
        //获取该目录下所有文件
        NSArray *filePathArray = [manager subpathsAtPath:path];
        
        for (NSString *fileName in filePathArray) {
            
            //拼接每个文件的路径
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            
            //计算每个文件的大小
            unsigned long long fileSize = [manager attributesOfItemAtPath:filePath error:nil].fileSize;
            
            returnFileSize += fileSize / 1024.0 / 1024.0;
        }
    }
    
    return returnFileSize;
}

/**
 清理缓存
 */
- (void)plClearCache {
    NSString *path = [self plGetCacheFilePath];
    
    //获取文件夹管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:path]) {
        
        //获取该目录下的所有文件
        NSArray *filePathArray = [manager subpathsAtPath:path];
        
        for (NSString *fileName in filePathArray) {
            
            //拼接路径
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            
            //删除文件
            [manager removeItemAtPath:filePath error:nil];
        }
    }
}

#pragma mark ----懒加载----
- (NSArray *)dataArray {
    return @[@"我的收藏", @"清理缓存", @"夜间模式"];
}

- (NSArray *)logoArray {
    return @[@"my_collect", @"my_clear", @"my_night"];
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
