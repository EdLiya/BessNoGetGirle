//
//  XMGEssenceViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGRecommendTagsViewController.h"
#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"

@interface XMGEssenceViewController () <UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];

    // 初始化子控制器
    [self setupChildVces];
    
    [self setupTitlesView];
    // 底部的scrollView
    [self setupContentView];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    XMGWordViewController *word = [[XMGWordViewController alloc] init];
    word.title = @"段子";
    [self addChildViewController:word];
    
    XMGAllViewController *all = [[XMGAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    XMGPictureViewController *picture = [[XMGPictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    XMGVideoViewController *video = [[XMGVideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    XMGVoiceViewController *voice = [[XMGVoiceViewController alloc] init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.frame = self.view.bounds;
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

  /**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = XMGTitilesViewH;
    titlesView.y = XMGTitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.tag = -1;
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i< self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    };
    
    // 放在所有的按钮之后去添加
    [titlesView addSubview:indicatorView];
}

/**
 * 设置导航栏
 */
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

#pragma mark - Action
- (void)tagClick
{
    XMGLogFunc;
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
//
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20) 在手机状态栏之下
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}
@end
