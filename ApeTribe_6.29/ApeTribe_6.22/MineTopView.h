//
//  MineTopView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickPortraitCallBackBlock)(long index);

@interface MineTopView : UIVisualEffectView


@property (nonatomic, strong) UIScrollView *topScrollView;// 滚动视图
@property (nonatomic, strong) UIView *bottomView;// 底部按钮视图
@property (nonatomic, strong) UIButton *portraitButton, *qrCodeButton, *commentLabel, *personalInfoButton;// 用户头像，二维码，动态，个人资料
@property (nonatomic, strong) UILabel *nameLabel,*addTimeLabel, *locationLabel, *devplatformLabel, *expertiseLabel;// 用户名，加入时间，所在地区，开发平台，专长领域
@property (nonatomic, strong) ClickPortraitCallBackBlock clickHandle;// 点击头像执行的代码块

- (instancetype) initWithFrame:(CGRect)frame;
// 设置视图的内容
- (void) setContentOfView:(BOOL)loginState;

@end
