//
//  SegmentBaseViewController.m
//  SEKTest
//
//  Created by Mac on 17/2/20.
//  Copyright © 2017年 lovemo. All rights reserved.
//

#import "SegmentBaseViewController.h"

@interface SegmentBaseViewController ()<SEKNavigationViewDelegate, UIScrollViewDelegate>


@end

@implementation SegmentBaseViewController

- (SEKNavigationView *)topNavView {
    if (_topNavView == nil) {
        _topNavView = [[SEKNavigationView alloc]init];
        _topNavView.delegate = self;
    }
    return _topNavView;
}

/// 底部的所有内容
- (UIScrollView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc]init];
        _contentView.frame = self.view.bounds;
        _contentView.y = 36 + 20;
        _contentView.delegate = self;
        _contentView.pagingEnabled = YES;
        [self.view insertSubview:_contentView atIndex:0];
        _contentView.contentSize = CGSizeMake(_contentView.width * self.childViewControllers.count, 0);
    }
    return _contentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewChange:) name:@"scrollViewDidScrollChange" object:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

#pragma mark --------------------  SEKNavigationViewDelegate  --------------------

- (void)navButtonClick:(UIButton *)button {
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
#pragma mark --------------------  UIScrollViewDelegate  --------------------
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [scrollView addSubview: vc.view];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    [self.topNavView updateBottomLineWithScrollView:scrollView];

}

- (void)scrollViewChange:(NSNotification *)noti {
    
    CGFloat offsetY = [noti.userInfo[@"scrollViewDidScrollChangeY"] floatValue];
    BOOL isCycleShow = [noti.userInfo[@"isCycleShow"] boolValue];

    CGFloat animateDuration = 0.2l;
    if (isCycleShow) {
        if (offsetY > - [UIScreen mainScreen].bounds.size.width * 175 / 375 ) {
            self.navigationController.navigationBar.hidden = YES;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            [UIView animateWithDuration:animateDuration animations:^{
                self.topNavView.y = 20;
            }];
            
        } else {
            self.navigationController.navigationBar.hidden = NO;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            [UIView animateWithDuration:animateDuration animations:^{
                self.topNavView.y = 64;
            }];
        }
    } else {
        if (offsetY > 64) {
            self.navigationController.navigationBar.hidden = YES;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            [UIView animateWithDuration:animateDuration animations:^{
                self.topNavView.y = 20;
            }];
            
        } else {
            self.navigationController.navigationBar.hidden = NO;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            [UIView animateWithDuration:animateDuration animations:^{
                self.topNavView.y = 64;
            }];
        }
    }

}

@end
