//
//  XMGRecommendCategoryCell.m
//  百思不得姐
//
//  Created by dev on 16/5/4.
//  Copyright © 2016年 dev. All rights reserved.
//

#import "XMGRecommendCategoryCell.h"
#import "XMGRecommendCategory.h"

@interface XMGRecommendCategoryCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation XMGRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = XMGRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = XMGRGBColor(219, 21, 26);
    
     // 当cell的selection为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}



- (void)setCategory:(XMGRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : XMGRGBColor(78, 78, 78);
}
@end
