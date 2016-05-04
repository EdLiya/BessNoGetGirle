//
//  XMGTabBarController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGEssenceViewController.h"
#import "XMGNewViewController.h"
#import "XMGFriendTrendsViewController.h"
#import "XMGMeViewController.h"
#import "XMGTabBar.h"
#import "XMGNavigationController.h"


@implementation XMGTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子控制器
    [self setupChildVc:[[XMGEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[XMGNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[XMGFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[XMGMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换tabBar
    [self setValue:[[XMGTabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    // 不能在这里设置背景色, 这里会去访问vc控制器的View,导致该控制器赖加载view,并且创建了
//    vc.view.backgroundColor = XMGGlobalBg;
    
    // 添加为子控制器
    XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end

/*
 颜色:
 
 24bit颜色: R G B
 * #ff0000
 * #ccee00
 * #000000
 * #ffffff
 
 32bit颜色: ARGB
 * #ff0000ff
 
 常见颜色:
 #ff0000 红色
 #00ff00 绿色
 #0000ff 蓝色
 #000000 黑色
 #ffffff 白色
 
 灰色的特点:RGB一样
 
 1024x1024像素的图片  32bit颜色
 
 1024x1024x32\8 == 1024x1024x4
 1024x1024x24\8 == 1024x1024x3
 
*/


