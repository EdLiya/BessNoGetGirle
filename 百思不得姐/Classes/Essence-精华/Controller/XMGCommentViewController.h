//
//  XMGCommentViewController.h
//  百思不得姐
//
//  Created by dev on 16/8/23.
//  Copyright © 2016年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;
@interface XMGCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) XMGTopic *topic;
@end
