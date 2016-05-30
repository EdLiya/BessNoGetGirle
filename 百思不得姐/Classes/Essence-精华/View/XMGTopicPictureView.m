//
//  XMGTopicPictureView.m
//  百思不得姐
//
//  Created by dev on 16/5/30.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>

@interface XMGTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@end

@implementation XMGTopicPictureView

+ (UIView *)pictureView
{
    // 这里为XIB的bug, 手动调整XIB子控件的顺序
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    [view.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 1000) {
            [view sendSubviewToBack:obj];
        }
    }];
    
    return view;
}

- (void)awakeFromNib
{
    // 取消自动拉伸状态, 以为导致给自己设置frame 的时候, 出现的意外拉伸状态
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    /**
     在不知道图片扩展名的情况下, 如何知道图片的真实类型?
     * 取出图片数据的第一个字节, 就可以判断出图片的真实类型
     */
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    self.seeBigButton.hidden = NO;
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}
@end
 