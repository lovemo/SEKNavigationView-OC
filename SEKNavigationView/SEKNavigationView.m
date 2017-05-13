//
//  SEKNavigationView.m
//  SEKTest
//
//  Created by Mac on 17/2/20.
//  Copyright © 2017年 lovemo. All rights reserved.
//

#import "SEKNavigationView.h"
#import "UIView+SEKExtension.h"

@implementation SEKNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titlesViewW = 0.0;
        self.titlesViewMargin = 6.0;
        self.indicatorViewMargin = 5.0;
        
        /// 标题按钮的正常颜色，即非选中颜色，建议在设置标题数组前设置此属性
        self.titleButtonNormalColor = [UIColor grayColor];
        
        /// 标题按钮的禁用颜色，即选中颜色，防止用户多次点击，建议在设置标题数组前设置此属性
        self.titleButtonDisabledColor = [UIColor redColor];
        
        /// 标题按钮的文字大小，建议在设置标题数组前设置此属性
        self.titleButtonTitleFont = [UIFont systemFontOfSize:14];
        
        /// 标题选中按钮的文字大小，建议在设置标题数组前设置此属性
         self.selectTitleButtonTitleFont = [UIFont systemFontOfSize:14];
        
        /// 标题视图是否居中
         self.isTitlesViewCenter = YES;
    }
    return self;
}
    
/// 标题视图的宽度
- (void)setTitlesViewW:(CGFloat)titlesViewW {
    _titlesViewW = titlesViewW;
    [self setNeedsLayout];
}
/// 标题视图中按钮的间隔距离
- (void)setTitlesViewMargin:(CGFloat)titlesViewMargin {
    _titlesViewMargin = titlesViewMargin;
    [self setNeedsLayout];
}
/// 指示器与按钮的间隔距离
- (void)setIndicatorViewMargin:(CGFloat)indicatorViewMargin {
    _indicatorViewMargin = indicatorViewMargin;
    [self setNeedsLayout];
}

    
/// 顶部的所有标签
- (UIScrollView *)titlesView {
    if (_titlesView == nil) {
        // 标签栏整体
        _titlesView = [[UIScrollView alloc]init];
        _titlesView.showsVerticalScrollIndicator = NO;
        _titlesView.showsHorizontalScrollIndicator = NO;
        _titlesView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titlesView];
    }
    return _titlesView;
}
/// 标签栏底部的红色指示器
- (UIView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc]init];
        // 底部的红色指示器
        _indicatorView.backgroundColor = [UIColor redColor];
        _indicatorView.tag = -1;
    }
    return _indicatorView;
}
/// 左边按钮，默认隐藏
- (UIButton *)leftButton {
    if (_leftButton == nil) {
        _leftButton = [[UIButton alloc]init];
        _leftButton.hidden = YES;
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}
/// 右边按钮，默认隐藏
- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc]init];
        _rightButton.hidden = YES;
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}
/// 标题数组
- (void)setTitles:(NSArray *)titles {
    _titles = [titles copy];
    NSInteger titleCount = titles.count;
    
    if (titleCount <= 0) {return;}
    
    for (NSInteger index = 0; index < titleCount; index ++ ) {
        UIButton *button = [[UIButton alloc]init];
        
        button.tag = index;
        [button setTitle:[titles objectAtIndex:index] forState:UIControlStateNormal];
        [button setTitleColor:self.titleButtonDisabledColor forState:UIControlStateDisabled];
        [button setTitleColor:self.titleButtonNormalColor forState:UIControlStateNormal];
        button.titleLabel.font = self.titleButtonTitleFont;
    
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:button];

        
        // 默认点击了哪个个按钮
        if (index == (self.isSelectedMiddleButton ? ((titleCount - 1) / 2) : 0)) {
            button.enabled = NO;
            self.selectedButton = button;
        }
    }
    [self.titlesView addSubview:self.indicatorView];
    [self setNeedsLayout];
    
}

- (void)updateBottomLineWithScrollView:(UIScrollView *)scrollView {
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = self.titlesView.subviews[index];

    [self titleClick:button];
}

- (void)titleClick:(UIButton *)button {
        // 修改按钮状态
        self.selectedButton.enabled = YES;
        button.enabled = NO;
        self.selectedButton = button;
        
        // 动画
        [UIView animateWithDuration:0.25 animations:^{
            //            self.indicatorView.width = self.isFillout ? (self.titlesViewW / self.titles.count) : button.titleLabel.width;
            self.indicatorView.width = self.isFillout ? (self.titlesViewW / self.titles.count) : button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        } completion:^(BOOL finished) {
            
        }];
    

    
        if (self.delegate) {
            [self.delegate navButtonClick:button];
        }
        
}
    
- (void)leftButtonClick:(UIButton *)button {
        if (self.delegate) {
            [self.delegate navLeftButtonClick:button];
    }
}
    
- (void)rightButtonClick:(UIButton *)button {
        if (self.delegate) {
            [self.delegate navRightButtonClick:button];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonItemX = 14.0;
    CGFloat buttonItemW = 28;
    // 布局左边按钮
    self.leftButton.x = buttonItemX;
    self.leftButton.y = (self.height - buttonItemW) * 0.5;
    self.leftButton.width = buttonItemW;
    self.leftButton.height = buttonItemW;
    
    // 布局右边按钮
    self.rightButton.x = self.width - buttonItemX - buttonItemW;
    self.rightButton.y = (self.height - buttonItemW) * 0.5;
    self.rightButton.width = buttonItemW;
    self.rightButton.height = buttonItemW;
    
    // 布局titlesView
    if (self.titles.count <= 0 || self.titlesView.subviews.count <= 0) {return; }
    self.titlesView.frame = self.bounds;
    self.titlesView.width = self.titlesViewW;
    if (self.isTitlesViewCenter) {
        self.titlesView.centerX = self.centerX;
    } else {
        self.titlesView.x = 0;;
    }
    
    self.indicatorView.height = 3;
    self.indicatorView.y = self.titlesView.height - self.indicatorView.height;
    
    CGFloat height = self.titlesView.height;
    UIButton *lastBtn = [[UIButton alloc] init];
    lastBtn.frame = CGRectZero;
    
    for (NSInteger index = 0; index < self.titles.count; index ++) {
        if (![self.titlesView.subviews[index] isKindOfClass:[UIButton class]]) {
            continue;
        }
        UIButton *button = self.titlesView.subviews[index];
        button.tag = index;
        button.height = height;
        [button sizeToFit];
        button.y = 2;
         button.x = CGRectGetMaxX(lastBtn.frame) + self.titlesViewMargin;
        CGFloat btnW = (self.titlesView.width - (self.titles.count + 1) * self.titlesViewMargin) / self.titles.count;
        
        CGSize titleSize = [button.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 36, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: button.titleLabel.font} context:nil].size;
        
        CGFloat btnLastW = titleSize.width;
        
        button.width = btnW > btnLastW ? btnW : btnLastW;
        lastBtn = button;
        
        
        self.rightButton.centerY = button.centerY;
        // 布局指示器的位置
        self.indicatorView.y = CGRectGetMaxY(button.frame) + self.indicatorViewMargin;
        
        if (index == (self.isSelectedMiddleButton ? ((self.titles.count - 1) / 2) : 0)) {
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = self.isFillout ? self.titlesViewW / (self.titles.count) : button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
        if (index == self.titles.count - 1) {
//            [button.titleLabel sizeToFit];
            // 设置titlesView的contentSize
            self.titlesView.contentSize = CGSizeMake( CGRectGetMaxX(button.frame), self.titlesView.height);
        }

    }
    
}


@end
