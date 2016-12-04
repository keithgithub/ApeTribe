//
//  BaseTableViewCell.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MineFansTableViewCellStyle,// 粉丝
    MineMsgTableViewCellStyle,// 私信
    MineAtMeTableViewCellStyle,// @我
    MineReplyTableViewCellStyle,// 评论
    MineLikeTableViewCellStyle,// 赞我
} MineTableViewCellStyle;
@protocol BaseTableViewCellDelegate <NSObject>
// 点击用户头像
- (void) clickButtonAction:(long)userId;

@end


@interface BaseTableViewCell : UITableViewCell
@property (assign, nonatomic) MineTableViewCellStyle style;// 单元格类型
@property (nonatomic, assign) id <BaseTableViewCellDelegate> delegate;
- (void) setCell:(id)obj;
@end
