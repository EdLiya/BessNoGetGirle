

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XMGTopicType) {
    XMGTopicTypeAll = 1,
    XMGTopicTypePicture = 10,
    XMGTopicTypeWord = 29,
    XMGTopicTypeVoice = 31,
    XMGTopicTypeVideo = 41
};

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const XMGTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const XMGTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const XMGTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const XMGTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const XMGTopicCellBottomBarH;


/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureBreakH;