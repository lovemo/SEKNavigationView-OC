//
//  ViewController.m
//  NavigationViewDemo
//
//  Created by Mac on 17/5/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SEKExtension.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.titles = @[@"网页", @"新闻", @"贴吧", @"知道", @"音乐", @"图片", @"视频", @"地图", @"文库", @"网盘", @"更多"];
    
    // 设置导航试图
    [self setupNavView];
    // 初始化子控制器
    [self setupChildVces];
    // 底部的scrollView
    [self setupContentView];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


/// 设置导航视图
- (void)setupNavView {
    self.navigationController.navigationBar.hidden = YES;
    self.topNavView.frame = CGRectMake(0, 20, self.view.width, 44);
    self.topNavView.backgroundColor = [UIColor whiteColor];
    self.topNavView.titleButtonNormalColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    self.topNavView.titleButtonDisabledColor = [UIColor redColor];
    self.topNavView.titleButtonTitleFont = [UIFont systemFontOfSize:16];
    self.topNavView.titles = self.titles;
    self.topNavView.titlesViewW = self.topNavView.width;

    if (self.isShowNavgationViewButton) {
        self.topNavView.titlesViewW = self.topNavView.width - 100;
        self.topNavView.leftButton.hidden = NO;
        self.topNavView.rightButton.hidden = NO;
        [self.topNavView.leftButton setImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
        [self.topNavView.rightButton setImage:[UIImage imageNamed:@"icon_videocam"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.topNavView];
}

/// 初始化子控制器
- (void)setupChildVces {

    for (id obj in self.titles) {
        UIViewController *voice = [[UIViewController alloc] init];
        [self addChildViewController:voice];
        voice.view.backgroundColor = [self randomColor];
    }
    
}
/// 底部的scrollView
- (void)setupContentView {
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:self.contentView];
}

- (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    CGFloat alpha = 1.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
