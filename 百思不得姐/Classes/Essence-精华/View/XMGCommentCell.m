//
//  XMGCommentCell.m
//  百思不得姐
//
//  Created by dev on 16/9/8.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGCommentCell.h"
#import "XMGComment.h"
#import <UIImageView+WebCache.h>
#import "XMGUser.h"

@interface XMGCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end


@implementation XMGCommentCell

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(XMGComment *)comment {
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [comment.user.sex isEqualToString:XMGUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

//- (void)setFrame:(CGRect)frame {
//    
//    frame.origin.x = XMGTopicCellMargin;
//    
//    frame.size.width = - 2 * XMGTopicCellMargin;
//    
//    [super setFrame:frame];
//}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = XMGTopicCellMargin;
//    frame.size.width -= 2 * XMGTopicCellMargin;
    
    [super setFrame:frame];
}

@end
