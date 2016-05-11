//
//  XMGVerticalButton.m
//  百思不得姐
//
//  Created by dev on 16/5/11.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGVerticalButton.h"

@implementation XMGVerticalButton

- (void)awakeFromNib {
    [self setup];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
