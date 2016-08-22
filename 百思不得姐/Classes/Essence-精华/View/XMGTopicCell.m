//
//  XMGTopicCell.m
//  百思不得姐
//
//  Created by dev on 16/5/13.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGTopicPictureView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicVideoView.h"


@interface XMGTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片帖子中间的内容 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;

/** 声音帖子中间的内容 */
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;

/** 视频帖子中间的内容 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;
@end

@implementation XMGTopicCell
- (XMGTopicPictureView *)pictureView {
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
- (void)setTopic:(XMGTopic *)topic {
    _topic = topic;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    
    self.createTimeLabel.text = topic.create_time; // 这个重写了create_time的get方法
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];

    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间  ( 要考虑cell的循环利用的影响 )
    if (topic.type == XMGTopicTypePicture) { // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == XMGTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == XMGTopicTypeVideo) {
         self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else { // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = XMGTopicCellMargin;            // cell 位置调整了 10 点
    frame.size.width -= 2 * XMGTopicCellMargin;     // 宽度减了 2*10 点
    frame.size.height -= XMGTopicCellMargin;        // 高度 减 10点
    frame.origin.y += XMGTopicCellMargin;           // 整体下移10点
    [super setFrame:frame];
}
@end
