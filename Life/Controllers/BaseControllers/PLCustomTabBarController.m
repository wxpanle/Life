//
//  PLCustomTabBarController.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLCustomTabBarController.h"
#import "PLHomeViewController.h"
#import "PLJokeViewController.h"
#import "PLAmuseViewController.h"
#import "PLMyViewController.h"

@interface PLCustomTabBarController ()

@end

@implementation PLCustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建viewController
    [self plCreateViewController];
    
    //创建tabbar
    [self plCreateTabBar];
}


#pragma mark ----创建界面视图----
- (void)plCreateViewController {
    
    //主页
    PLHomeViewController *plHomeVC = [[PLHomeViewController alloc] init];
    UINavigationController *plHomeNAV = [[UINavigationController alloc] initWithRootViewController:plHomeVC];
    
    //美食
    PLJokeViewController *plFoodVC = [[PLJokeViewController alloc] init];
    UINavigationController *plFoodNAV = [[UINavigationController alloc] initWithRootViewController:plFoodVC];
    
    //娱乐
    PLAmuseViewController *plAmuseVC = [[PLAmuseViewController alloc] init];
    UINavigationController *plAmuseNAV = [[UINavigationController alloc] initWithRootViewController:plAmuseVC];
    
    //我的
    PLMyViewController *plMyVC = [[PLMyViewController alloc] init];
    UINavigationController *plMyNAV = [[UINavigationController alloc] initWithRootViewController:plMyVC];
    
    self.viewControllers = @[plHomeNAV, plFoodNAV, plAmuseNAV, plMyNAV];
}

#pragma mark ----创建tabBar----
- (void)plCreateTabBar {
    
    //未选中的图片
    NSArray *unselectedImageArray = @[@"home_unselected", @"joke_unselected", @"amuse_unselected", @"my_unselected"];
    //选中的图片
    NSArray *selectedImageArray = @[@"home_selected", @"joke_selected", @"amuse_selected", @"my_selected"];
    //标题
    NSArray *titleArray = @[@"首页",@"段子",@"娱乐",@"我的"];
    
    for (NSInteger i = 0; i < self.tabBar.items.count; i++) {
        UIImage *unselectedImage = [UIImage imageNamed:[unselectedImageArray objectAtIndex:i]];
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *selectedImage = [UIImage imageNamed:[selectedImageArray objectAtIndex:i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
        
        item.imageInsets = UIEdgeInsetsMake(3, 0, 0, 0);
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(240, 100, 100, 1)} forState:UIControlStateSelected];
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
