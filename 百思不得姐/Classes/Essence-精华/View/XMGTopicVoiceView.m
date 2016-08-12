//
//  XMGTopicVoiceView.m
//  百思不得姐
//
//  Created by dev on 16/8/12.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGTopicVoiceView.h"

@implementation XMGTopicVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
