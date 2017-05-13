//
//  SEKNavigationView.h
//  SEKTest
//
//  Created by Mac on 17/2/20.
//  Copyright © 2017年 lovemo. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 导航栏代理
@protocol SEKNavigationViewDelegate <NSObject>

@optional
    /// 导航栏按钮点击
    - (void)navButtonClick:(UIButton *)button;
    /// 导航栏按钮点击
    - (void)navLeftButtonClick:(UIButton *)button;
    /// 导航栏按钮点击
    - (void)navRightButtonClick:(UIButton *)button;

@end

@interface SEKNavigationView : UIView

/// 内部按钮点击代理
@property (nonatomic, weak)  id<SEKNavigationViewDelegate> delegate;

/// 当前选中的按钮
@property (nonatomic, strong) UIButton *selectedButton;

/// 是否铺满
@property (nonatomic, assign) BOOL  isFillout;

/// 是否默认选中中间按钮
@property (nonatomic, assign) BOOL  isSelectedMiddleButton;

/// 标题视图的宽度
@property (nonatomic, assign) CGFloat  titlesViewW;

/// 标题视图中按钮的间隔距离
@property (nonatomic, assign) CGFloat  titlesViewMargin;

/// 标题视图是否居中
@property (nonatomic, assign) BOOL  isTitlesViewCenter;

/// 指示器与按钮的间隔距离
@property (nonatomic, assign) CGFloat  indicatorViewMargin;

/// 标题按钮的正常颜色，即非选中颜色，建议在设置标题数组前设置此属性
@property (nonatomic, strong) UIColor *titleButtonNormalColor;

/// 标题按钮的禁用颜色，即选中颜色，防止用户多次点击，建议在设置标题数组前设置此属性
@property (nonatomic, strong) UIColor *titleButtonDisabledColor;

/// 标题按钮的文字大小，建议在设置标题数组前设置此属性
@property (nonatomic, assign) UIFont  *titleButtonTitleFont;

/// 标题选中按钮的文字大小，建议在设置标题数组前设置此属性
@property (nonatomic, assign) UIFont  *selectTitleButtonTitleFont;

/// 顶部的所有标签
@property (nonatomic, strong) UIScrollView *titlesView;

/// 标签栏底部的红色指示器
@property (nonatomic, strong) UIView *indicatorView;

/// 左边按钮，默认隐藏
@property (nonatomic, strong) UIButton *leftButton;

/// 右边按钮，默认隐藏
@property (nonatomic, strong) UIButton *rightButton;

/// 标题数组
@property (nonatomic, strong) NSArray *titles;

/// 右边按钮的frame
@property (nonatomic, assign) CGRect  rightButtonFrame;


- (void)titleClick:(UIButton *)button ;

-(void)updateBottomLineWithScrollView:(UIScrollView *)scrollView;

@end
