//
//  XMGTopic.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/27.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTopic.h"
#import <MJExtension.h>

@implementation XMGTopic
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

/**
 今年
    今天
        1分钟内
            刚刚
        1小时内
            xx分钟前
        其他
            xx小时前
    昨天
        昨天 18:56:34
        其他
        06-23 19:56:23
 
非今年
    2014-05-08 18:45:30
 */
- (NSString *)create_time {
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}


- (CGFloat)cellHeight {
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * XMGTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        // 文字部分的高度
        _cellHeight = XMGTopicCellTextY + textH + XMGTopicCellMargin;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == XMGTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= XMGTopicCellPictureMaxH) { // 图片高度过长
                pictureH = XMGTopicCellPictureBreakH;
                self.bigPicture = YES; // 大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = XMGTopicCellMargin;
            CGFloat pictureY = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + XMGTopicCellMargin;
        } else if (self.type == XMGTopicTypeVoice) { // 声音帖子
            CGFloat voiceX = XMGTopicCellMargin;
            CGFloat voiceY = XMGTopicCellTextY + textH + XMGTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + XMGTopicCellMargin;
        }
        
        // 加上底部工具条的高度
        _cellHeight += XMGTopicCellBottomBarH;
        _cellHeight += XMGTopicCellMargin; // 加上高度补全, (在cell的setFrame里, 高度-10 的补全)
    }
    return _cellHeight;
}
@end
