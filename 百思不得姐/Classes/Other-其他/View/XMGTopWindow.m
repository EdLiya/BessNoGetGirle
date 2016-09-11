//
//  XMGTopWindow.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/8/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTopWindow.h"

@implementation XMGTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    
    window_.rootViewController = [UIViewController new]; // UIWindow 必须要有一个根控制器
    
    window_.backgroundColor = [UIColor clearColor];
    window_.frame = CGRectMake(0, 0, XMGScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    
}

+ (void)show
{
    window_.hidden = NO;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        
//        CGRectIntersectsRect([UIApplication sharedApplication].keyWindow.bounds, subview.frame)
        
//        CGRect newFrame = [subview.superview convertRect:subview.frame toView:nil];
//        CGRect newFrame = [[UIApplication sharedApplication].keyWindow convertRect:subview.frame fromView:subview.superview];
        
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]]) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
@end
