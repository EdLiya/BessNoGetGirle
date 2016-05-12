//
//  XMGPushGuideView.m
//  百思不得姐
//
//  Created by dev on 16/5/11.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGPushGuideView.h"

@implementation XMGPushGuideView

+ (instancetype)guideView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (IBAction)close {
    [self removeFromSuperview];
}

+ (void)show {
    NSString *key = @"CFBundleShortVersionString";
    // 获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        XMGPushGuideView *guideView = [XMGPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
