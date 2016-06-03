//
//  XMGShowPictureViewController.h
//  百思不得姐
//
//  Created by dev on 16/6/2.
//  Copyright © 2016年 dev. All rights reserved.
//  显示图片控制器

#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGShowPictureViewController : UIViewController
/** 帖子 */
@property (nonatomic, strong) XMGTopic *topic;
@end
