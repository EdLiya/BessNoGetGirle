//
//  XMGTopicPictureView.h
//  百思不得姐
//
//  Created by dev on 16/5/30.
//  Copyright © 2016年 dev. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>

@class XMGTopic;
@interface XMGTopicPictureView : UIView
+ (UIView *)pictureView;

/** 帖子数据 */
@property (nonatomic, strong) XMGTopic *topic;
@end
