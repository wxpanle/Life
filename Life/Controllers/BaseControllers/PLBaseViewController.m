//
//  PLBaseViewController.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLBaseViewController.h"

@interface PLBaseViewController ()

@end

@implementation PLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建左右按钮
    [self plCreateLeftAndRightButton];
    
    //创建tableView
    [self plCreateTableViewUI];
}

#pragma mark ---创建tableView-----
- (void)plCreateTableViewUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource =self;
    _tableView.delegate = self;
    
    //设置cell的虚拟高度,默认情况下为0
    _tableView.estimatedRowHeight = 44.f;
    
    [self.view addSubview:_tableView];
}

#pragma mark ----创建左右按钮----
/**
 创建左右按钮
 */
- (void)plCreateLeftAndRightButton {
    //设置导航栏透明状态
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航条的颜色
    self.navigationController.navigationBar.barTintColor = RGB(230, 230, 230, 1);
    
    //设置文字的颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : RGB(100, 160, 220, 1)};
    
    //左按钮
//    self.leftButton = [FactoryUI plCreateButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"" backgroundImageName:nil target:nil selector:nil];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    
    //右按钮
    self.rightButton = [FactoryUI plCreateButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"" backgroundImageName:nil target:nil selector:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}

#pragma mark ----左/右按钮事件----
///**
// 左按钮事件
// */
//-(void)plAddLeftButtonAction:(SEL)selector {
//    
//    [self.leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
//    
//}

/**
 右按钮事件
 */
-(void)plAddRightButtonAction:(SEL)selector {
    
    [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseid = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:reuseid];
    }
    
    return cell;
}

#pragma mark ----导航栏的返回视图----
- (void)plCreateBackBarButtomItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
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
