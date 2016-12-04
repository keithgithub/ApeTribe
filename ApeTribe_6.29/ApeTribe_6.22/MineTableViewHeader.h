//
//  MineTableViewHeader.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "OtherUserXMLModel.h"
typedef void(^ClickAvatarCallBack)(int index);
typedef void(^OnClick)(long index);

@interface MineTableViewHeader : UIVisualEffectView
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIImageView *portraitImgV;
@property (nonatomic, strong) UIButton *integralButton, *focusButton, *fansButton;
@property (nonatomic, strong) UILabel *intergralLabel, *focusLabel, *fansLabel, *locationLb, *lastLoginTime;// 积分，关注，粉丝
@property (nonatomic, strong) OnClick clickhandle;
@property (nonatomic, strong) ClickAvatarCallBack tapHandle;
@property (nonatomic, assign) BOOL isMe;

- (instancetype) initWithFrame:(CGRect)frame andState:(BOOL)isMe;

- (void) setContentOfView:(OtherUserXMLModel *)model;
@end
