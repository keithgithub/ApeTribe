//
//  MineTableViewHeader.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MineTableViewHeader.h"
#import "HelpClass.h"
#import "UUImageAvatarBrowser.h"
#import "ShareSheet.h"
@implementation MineTableViewHeader

#pragma mark - getter
- (UILabel *) lastLoginTime
{
    if (!_lastLoginTime)
    {
        _lastLoginTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.frame.size.width, 25)];
        _lastLoginTime.center = CGPointMake(self.frame.size.width / 2.0, self.lastLoginTime.center.y);
        _lastLoginTime.textAlignment = NSTextAlignmentCenter;
        _lastLoginTime.font = FONT(11);
        _lastLoginTime.textColor = COLOR_FONT_D_GRAY;
    }
    return _lastLoginTime;
}

- (UIView *) bottomView
{
    if (!_bottomView)
    {
        CGFloat btnOriginY = 0;
        CGFloat originY = 35;// 标签的纵坐标
        CGFloat btnFont = 12.5;
        if (self.isMe)
        {
            // ============视图=============
            _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 80, self.frame.size.width, 80)];
            _bottomView.backgroundColor = [UIColor whiteColor];
            
            
        }
        else
        {
            // ============视图=============
            btnOriginY = -6;
            originY = 30;
            btnFont = 13;
            _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 90, self.frame.size.width, 90)];
            _bottomView.backgroundColor = [UIColor whiteColor];
            
            [_bottomView addSubview:self.lastLoginTime];
            
        }
        // ===========标签=============
        
        // 所在地
        self.locationLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width - 40, 21)];
        self.locationLb.center = CGPointMake(self.frame.size.width / 2.0, self.locationLb.center.y);
        self.locationLb.textAlignment = NSTextAlignmentCenter;
        
        self.locationLb.textColor = COLOR_FONT_L_GRAY;
        [_bottomView addSubview:self.locationLb];
        
        
        
        // 积分标签
        self.intergralLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, originY, self.frame.size.width / 3.0, 21)];
        self.intergralLabel.text = @"0";
        self.intergralLabel.font = FONT(12.5);
        self.intergralLabel.textColor = COLOR_FONT_D_GRAY;
        self.intergralLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:self.intergralLabel];
        
        // 关注标签
        self.focusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 3.0, originY, self.frame.size.width / 3.0, 21)];
        self.focusLabel.text = @"0";
        self.focusLabel.font = FONT(12.5);
        self.focusLabel.textColor = COLOR_FONT_D_GRAY;
        self.focusLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:self.focusLabel];
        
        // 粉丝标签
        self.fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 2 / 3.0, originY, self.frame.size.width / 3.0, 21)];
        self.fansLabel.text = @"0";
        self.fansLabel.font = FONT(12.5);
        self.fansLabel.textColor = COLOR_FONT_D_GRAY;
        self.fansLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:self.fansLabel];
        
        // ===============按钮================
        // 积分
        self.integralButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.integralButton.frame = CGRectMake(0, originY + btnOriginY + 13, self.frame.size.width / 3.0, 21);
        self.integralButton.tintColor = COLOR_FONT_D_GRAY;
        self.integralButton.titleLabel.font = FONT(btnFont);
        [self.integralButton setTitle:@"积分" forState:UIControlStateNormal];
        self.integralButton.tag = 301;
        [self.integralButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.integralButton];
        
        // 关注
        self.focusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.focusButton.frame = CGRectMake(self.frame.size.width / 3.0, originY + btnOriginY + 13, self.frame.size.width / 3.0, 21);
        [self.focusButton setTitle:@"关注" forState:UIControlStateNormal];
        self.focusButton.tintColor = COLOR_FONT_D_GRAY;
        self.focusButton.titleLabel.font = FONT(btnFont);
        self.focusButton.tag = 302;
        [self.focusButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.focusButton];
        
        // 粉丝
        self.fansButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.fansButton.frame = CGRectMake(self.frame.size.width * 2 / 3.0, originY + btnOriginY + 13, self.frame.size.width / 3.0, 21);
        [self.fansButton setTitle:@"粉丝" forState:UIControlStateNormal];
        self.fansButton.tintColor = COLOR_FONT_D_GRAY;
        self.fansButton.titleLabel.font = FONT(btnFont);
        self.fansButton.tag = 303;
        [self.fansButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.fansButton];
        
        // 分割线
        // ==========横线========
        UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(0, _bottomView.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        lineLb.backgroundColor = COLOR_BG_L_GRAY;
        [_bottomView addSubview:lineLb];
        
        // ===========竖线========
        UILabel *lineLb1 = [[UILabel alloc]initWithFrame:CGRectMake(self.focusLabel.frame.origin.x - 0.5, self.intergralLabel.frame.origin.y + 8, 0.5, 20)];
        lineLb1.backgroundColor = COLOR_BG_L_GRAY;
        [_bottomView addSubview:lineLb1];
        
        
        UILabel *lineLb2 = [[UILabel alloc]initWithFrame:CGRectMake(self.fansLabel.frame.origin.x - 0.5, self.intergralLabel.frame.origin.y + 8, 0.5, 20)];
        lineLb2.backgroundColor = COLOR_BG_L_GRAY;
        [_bottomView addSubview:lineLb2];
        
        
    }
    return _bottomView;
}

- (UIImageView *) portraitImgV
{
    if (!_portraitImgV)
    {
        _portraitImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _portraitImgV.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height - _bottomView.frame.size.height - _portraitImgV.frame.size.height / 2.0 - 20);
        self.portraitImgV.layer.cornerRadius = self.portraitImgV.frame.size.height / 2.0;
        self.portraitImgV.layer.masksToBounds = YES;
        self.portraitImgV.userInteractionEnabled = YES;
        self.portraitImgV.layer.borderColor = [UIColor whiteColor].CGColor;
        self.portraitImgV.layer.borderWidth = 2.0;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPortraitAction)];
        [self.portraitImgV addGestureRecognizer:tapGestureRecognizer];
    }
    return _portraitImgV;
}

#pragma mark - init
- (instancetype) initWithFrame:(CGRect)frame andState:(BOOL)isMe
{
    if (self = [super initWithFrame:frame])
    {
        // 设置毛玻璃效果
//        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        [self setEffect:blur];
//        [self setEffect:nil];
        self.isMe = isMe;
        UIView *contentView = [[UIView alloc]initWithFrame:self.bounds];
        contentView.tag = 401;
        // 添加滚动视图
        [contentView addSubview:self.bottomView];
        [contentView addSubview:self.portraitImgV];
        [self addSubview:contentView];
        
        
        
        
    }
    return self;
}

- (void) setContentOfView:(OtherUserXMLModel *)model
{
    if (self.isMe) {
        if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"0"])
        {
            // 未登录
            self.portraitImgV.image = Image(@"headIcon_placeholder");
            self.intergralLabel.text = @"0";
            self.focusLabel.text = @"0";
            self.fansLabel.text = @"0";
            self.locationLb.text = @"";
        }
        else
        {
            // 已登录
            [self.portraitImgV sd_setImageWithURL:URL(USER_MODEL.portrait) placeholderImage:Image(@"headIcon_placeholder")];
            self.intergralLabel.text = [NSString stringWithFormat:@"%ld",USER_MODEL.score];
            self.focusLabel.text = [NSString stringWithFormat:@"%ld",USER_MODEL.followers];
            self.fansLabel.text = [NSString stringWithFormat:@"%ld",USER_MODEL.fans];
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:USER_MODEL.city];
            NSTextAttachment *imageAttachment = [[NSTextAttachment alloc]init];
            imageAttachment.bounds = CGRectMake(0, -2, 13, 13);
            if (USER_MODEL.gender == 1)
            {
                imageAttachment.image = Image(@"userinfo_icon_male");
            }
            else
            {
                imageAttachment.image = Image(@"userinfo_icon_female");
            }
            NSAttributedString *imageAttribute = [NSAttributedString attributedStringWithAttachment:imageAttachment];
            [text appendAttributedString:imageAttribute];
            self.locationLb.attributedText = text;
            self.locationLb.font = FONT(13);
        }
        NSLog(@"intergral = %ld\nfocus = %ld\nfans = %ld",USER_MODEL.score,USER_MODEL.followers,USER_MODEL.fans);
    }
    else
    {
        
        [self.portraitImgV sd_setImageWithURL:URL(model.portrait) placeholderImage:Image(@"headIcon_placeholder")];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:model.city];
        
        NSTextAttachment *imageAttachment = [[NSTextAttachment alloc]init];
        
        if (USER_MODEL.gender == 1)
        {
            imageAttachment.image = Image(@"userinfo_icon_male");
        }
        else
        {
            imageAttachment.image = Image(@"userinfo_icon_female");
        }
        imageAttachment.bounds = CGRectMake(0, -2, 13, 13);
        NSAttributedString *imageAttribute = [NSAttributedString attributedStringWithAttachment:imageAttachment];
        [text appendAttributedString:imageAttribute];
        self.locationLb.attributedText = text;
        self.locationLb.font = FONT(13);
        self.lastLoginTime.text = [NSString stringWithFormat:@"最近登录：%@",[HelpClass compareCurrentTime:model.latestLoginTime]];
        self.intergralLabel.text = @"";
        self.focusLabel.text = @"";
        self.fansLabel.text = @"";
    }
    
}

- (void) btnAction:(UIButton *)sender
{
    if (self.clickhandle != nil)
    {
        self.clickhandle(sender.tag - 300);
    }
}
- (void) tapPortraitAction
{
    
    if (self.tapHandle != nil)
    {
        if (self.isMe)
        {
            if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"]) {
                NSArray *arr = @[@"查看头像",@"更改头像"];
                __weak typeof(self) weakself = self;
                ShareSheet *sheet = [ShareSheet shareSheetWithStyle:ShareSheetTableStyle andArrData:arr andHandle:^(long index) {
                    switch (index)
                    {
                        case 0:
                            [UUImageAvatarBrowser showImage:self.portraitImgV];
                            break;
                        case 1:
                        {
                            ShareSheet *sheet1 = [ShareSheet shareSheetWithStyle:ShareSheetTableStyle andArrData:@[@"相册",@"相机"] andHandle:^(long index) {
                                weakself.tapHandle((int)index);
                            } andTitle:@"选择图片来源"];
                            [sheet1 show];
                        }
                            break;
                            
                        default:
                            
                            break;
                            
                    }
                    
                } andTitle:nil];
                // 显示
                [sheet show];
            }

        }
        else
        {
            [UUImageAvatarBrowser showImage:self.portraitImgV];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
