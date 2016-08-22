//
//  XMGTopicVoiceView.h
//  百思不得姐
//
//  Created by dev on 16/8/12.
//  Copyright © 2016年 dev. All rights reserved.
//  声音帖子中间的内容

#import <UIKit/UIKit.h>

@class XMGTopic;
@interface XMGTopicVoiceView : UIView

/** 帖子数据 */
@property (nonatomic, strong) XMGTopic *topic;

+ (instancetype)voiceView;

@end
