//
//  XMGTopicCell.h
//  百思不得姐
//
//  Created by dev on 16/5/13.
//  Copyright © 2016年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGTopicCell : UITableViewCell
/** 帖子数据 */
@property (nonatomic, strong) XMGTopic *topic;
@end
