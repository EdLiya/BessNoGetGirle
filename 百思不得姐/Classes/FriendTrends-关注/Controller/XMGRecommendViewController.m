//
//  XMGRecommendViewController.m
//  百思不得姐
//
//  Created by dev on 16/5/4.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "XMGRecommendCategoryCell.h"
#import <MJExtension.h>
#import "XMGRecommendCategory.h"
#import "XMGRecommendUserCell.h"
#import "XMGRecommendUser.h"

@interface XMGRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@end

static NSString * const XMGCategoryId = @"category";
static NSString * const XMGUserId = @"user";

@implementation XMGRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     // 控件的初始化
    [self setupTableView];
    
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        self.categories = [XMGRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
         // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        
//        XMGLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
}

- (void)setupTableView
{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XMGUserId];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 设置标题
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        return self.categories.count;
    } else { // 右边的用户表格
         // 左边被选中的类别模型
        XMGRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        return c.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        XMGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        XMGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
        XMGRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        [self.categoryTableView reloadData];
    } else {
        // 发送请求给服务器, 加载右侧的数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *users = [XMGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [c.users addObjectsFromArray:users];
            
            // 刷新右边的表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
}

/**
 1.重复发送请求
 2.目前只能显示1页数据
 3.网络慢带来的细节问题
 */
@end
