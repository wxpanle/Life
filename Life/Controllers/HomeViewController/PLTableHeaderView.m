//
//  PLTableHeaderView.m
//  Life
//
//  Created by qianfeng on 16/5/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PLTableHeaderView.h"

typedef NS_ENUM(NSInteger, scrollDirection) {
    scrollDirectionLeft = 0,
    scrollDirectionRight
};

@interface PLTableHeaderView () {
    UIScrollView *_scrollView;
    UIPageControl *_pageVC;
    scrollDirection status;
}

//定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PLTableHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //添加自定义的视图
        [self plAddCustomViewUI];
    }
    return self;
}

//添加自定义的视图
- (void)plAddCustomViewUI {
    
    //创建滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 60)];
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    //创建pageControl
    _pageVC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 80, self.bounds.size.width, 20)];
    _pageVC.pageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:_pageVC];
}


/**
 开始自动滚动视图
 */
- (void)plStartAutomaticScrollImage {
    
    if (_timer) {
        [_timer setFireDate:[NSDate distantPast]];
        return;
    }
    
    if (self.urlImageArray == nil) {
        return;
    }
    
    //为scrollView添加图片
    for (NSInteger i = 0; i < self.urlImageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.urlImageArray objectAtIndex:i]]];
        [_scrollView addSubview:imageView];
    }
    
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * self.urlImageArray.count, self.bounds.size.height);
    
    _pageVC.numberOfPages = self.urlImageArray.count;
    _pageVC.currentPage = 0;
    
    
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(plRefreshPageAndImageView) userInfo:nil repeats:YES];
    
    //设置滚动方向
    status = scrollDirectionRight;
}

/**
 停止自动滚动视图
 */
- (void)plStopAutomaticScrollImage {
    //停止定时器
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)plRefreshPageAndImageView {
    //更新数据
    if (status == scrollDirectionRight) {
        _pageVC.currentPage++;
        
        if (_pageVC.currentPage == self.urlImageArray.count - 1) {
            _pageVC.currentPage = self.urlImageArray.count - 1;
            status = scrollDirectionLeft;
        }
    } else if (status == scrollDirectionLeft) {
        _pageVC.currentPage--;
        
        if (_pageVC.currentPage == 0) {
            status = scrollDirectionRight;
        }
    }
    
    _scrollView.contentOffset = CGPointMake(_pageVC.currentPage * self.bounds.size.width, 0);
    
}
@end
