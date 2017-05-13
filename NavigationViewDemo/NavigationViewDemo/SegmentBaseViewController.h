//
//  SegmentBaseViewController.h
//  SEKTest
//
//  Created by Mac on 17/2/20.
//  Copyright © 2017年 lovemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SEKExtension.h"
#import "SEKNavigationView.h"

@interface SegmentBaseViewController : UIViewController<SEKNavigationViewDelegate>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) SEKNavigationView *topNavView;

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end
