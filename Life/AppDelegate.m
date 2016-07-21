//
//  AppDelegate.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "PLCustomTabBarController.h"

@interface AppDelegate ()

@property (nonatomic, strong) PLCustomTabBarController *plCusTabBar;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.plCusTabBar = [[PLCustomTabBarController alloc] init];
    self.window.rootViewController = self.plCusTabBar;
    
    //创建数据库
    [self plCreateCoreData];
    
    //注册友盟相关
    [self addUmSocial];
    
    return YES;
}

/**
 添加数据库
 */
- (void)plCreateCoreData {
    //数据库准备
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"/Life.db"];
}

- (void)addUmSocial {
    [UMSocialData setAppKey:@"5729571567e58e414b0003e5"];
    
    //qq的需要在腾讯开放平台申请
    //设置qq的appid和appkey
    //在实际项目开发中,填写的是公司的网址或者对应的app在appStore里面的下载链接,如果设置为nil的话,默认表示友盟的官方网址
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    
    //微信的需要在微信开放平台申请
    //设置微信的appid appsecret
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    
    //为了苹果的审核规定,在使用分享的时候,要隐藏设备上未安装的客户端,否则审核不通过,主要针对qq和微信
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
