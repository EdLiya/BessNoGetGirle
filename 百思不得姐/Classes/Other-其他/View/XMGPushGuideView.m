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

@end
