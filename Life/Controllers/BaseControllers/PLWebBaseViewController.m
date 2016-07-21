//
//  PLWebBaseViewController.m
//  Life
//
//  Created by qianfeng on 16/5/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLWebBaseViewController.h"

@interface PLWebBaseViewController () {
    UIWebView *_webView;
}

@property (nonatomic, copy) NSString *str;

@end

@implementation PLWebBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建UIWebView
    [self plCreateWebView];
    
    //重置导航栏属性
    [self replaceNAV];
}

#pragma mark ---重置导航栏属性---
- (void)replaceNAV {
    
    //创建分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Home_Detail_Share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(plShareArticalOrLife)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    //收藏按钮
    self.collectButton = [FactoryUI plCreateButtonWithFrame:CGRectMake(SCREEN_W - 50, 40, 40, 40) title:nil titleColor:nil imageName:@"Home_Detail_Collection" backgroundImageName:nil target:self selector:@selector(collectionButtonClick:)];
    [self.collectButton setImage:[UIImage imageNamed:@"Home_Detail_Collection-2"] forState:UIControlStateSelected];
    [self.view addSubview:self.collectButton];
}

/**
 分享
 */
- (void)plShareArticalOrLife {
    //shareText在实际项目开发中是从服务器获取的字符串 shareImage是从服务器获取的图片 一般从服务器获取到的是图片的地址，需要转化为UIimage对象 shareToSnsNames:需要分享到的平台名称
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5729571567e58e414b0003e5" shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.dataID] shareImage:nil shareToSnsNames:@[UMShareToQQ, UMShareToQzone, UMShareToSina] delegate:nil];
}

- (void)collectionButtonClick:(UIButton *)button {
    
}

#pragma mark ----创建UIWebView----
- (void)plCreateWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    //自适应屏幕大小
    _webView.scalesPageToFit = YES;
    
    //加载数据
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.dataID]]]];
    
    [self.view addSubview:_webView];
    
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
