//
//  MineTopView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MineTopView.h"
#import "HelpClass.h"
@implementation MineTopView
#pragma mark - getter
- (UIScrollView *)topScrollView
{
    if (!_topScrollView)
    {
        // 创建滚动视图
        self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 140, self.frame.size.width, 90)];
        
        self.topScrollView.contentSize = CGSizeMake(self.frame.size.width * 2, 0);
        self.topScrollView.pagingEnabled = YES;
        self.topScrollView.showsHorizontalScrollIndicator = NO;
        self.topScrollView.bounces = NO;
        
        // =======创建滚动视图第一个页面======
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.topScrollView.frame.size.width, self.topScrollView.frame.size.height)];
        UIColor *color = [UIColor colorWithWhite:0.965 alpha:1.000];
        [self.topScrollView addSubview:firstView];
        
        // 创建用户头像按钮
        self.portraitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.portraitButton.frame = CGRectMake(20, 10, 60, 60);
        [self.portraitButton setBackgroundImage:Image(@"headIcon_placeholder") forState:UIControlStateNormal];
         
        self.portraitButton.layer.masksToBounds = YES;
        self.portraitButton.layer.cornerRadius = self.portraitButton.frame.size.height /  2.0;
        self.portraitButton.layer.borderWidth = 2.0;
        self.portraitButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.portraitButton addTarget:self action:@selector(clickPortraitAction) forControlEvents:UIControlEventTouchUpInside];
        [firstView addSubview:self.portraitButton];
        
        // 创建用户昵称标签
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, firstView.frame.size.height, firstView.frame.size.width - 20, 21)];
        self.nameLabel.center = CGPointMake(self.nameLabel.center.x, self.portraitButton.center.y);
        
        self.nameLabel.textColor = [UIColor whiteColor];
        
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [firstView addSubview:self.nameLabel];
        
        // ======创建滚动视图的第二个页面=========
        UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(self.topScrollView.frame.size.width + 20, 0, self.topScrollView.frame.size.width - 100, self.topScrollView.frame.size.height - 10)];
        secondView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.146];
        secondView.layer.cornerRadius = 5;
        secondView.layer.masksToBounds = YES;
        [self.topScrollView addSubview:secondView];
        
        CGFloat originX = 5;
        self.addTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX, 0, IPHONE_W - 40, 21)];
        
        self.addTimeLabel.textColor = [UIColor whiteColor];
        self.addTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.addTimeLabel.font = FONT(12.5);
        
        self.locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX, 20, IPHONE_W - 40, 21)];
        
        self.locationLabel.textColor = [UIColor whiteColor];
        self.locationLabel.textAlignment = NSTextAlignmentLeft;
        self.locationLabel.font = FONT(12.5);
        
        self.devplatformLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX, 40, IPHONE_W - 40, 21)];
        
        self.devplatformLabel.textColor = [UIColor whiteColor];
        self.devplatformLabel.textAlignment = NSTextAlignmentLeft;
        self.devplatformLabel.font = FONT(12.5);
        
        self.expertiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX, 60, IPHONE_W - 40, 21)];
        
        self.expertiseLabel.textColor = [UIColor whiteColor];
        self.expertiseLabel.textAlignment = NSTextAlignmentLeft;
        self.expertiseLabel.font = FONT(12.5);
        
        
        
        
        [secondView addSubview:self.addTimeLabel];
        [secondView addSubview:self.locationLabel];
        [secondView addSubview:self.devplatformLabel];
        [secondView addSubview:self.expertiseLabel];
    }
    return _topScrollView;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
        
        // =======按钮==========
        NSArray *arrTitles = @[@"",@"动态",@"博客",@"资料"];
        for (int i = 0; i < 4; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake((_bottomView.frame.size.width - 60) * i / 4.0, 0, (_bottomView.frame.size.width - 60) / 4.0, _bottomView.frame.size.height);
            btn.tag = 410 + i;
            [btn setTitle:arrTitles[i] forState:UIControlStateNormal];
            btn.tintColor = COLOR_FONT_D_GRAY;
            btn.titleLabel.font = FONT(12.5);
            btn.backgroundColor = [UIColor whiteColor];
            if (i == 0)
            {

                btn.backgroundColor = COLOR_FONT_D_GREEN;
                [btn setImage:[Tool getRendingImageWithName:@"ScanQRCode1"] forState:UIControlStateNormal];
            }
            else
            {
                
            }
            [_bottomView addSubview:btn];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 1 || i == 2 || i == 3)
            {
                UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake((_bottomView.frame.size.width - 60) * i / 4.0, 0, 0.5, _bottomView.frame.size.height)];
                lineLb.backgroundColor = COLOR_BG_D_GRAY;
                [_bottomView addSubview:lineLb];
            }
            
        }
        
        
    }
    return _bottomView;
}

#pragma mark - init
- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置毛玻璃效果
//        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        [self setEffect:blur];
        
        UIView *contentView = [[UIView alloc]initWithFrame:self.bounds];
        contentView.tag = 400;

        // 添加滚动视图
        [contentView addSubview:self.topScrollView];
        [contentView addSubview:self.bottomView];
        [self addSubview:contentView];
        
//        [self setEffect:nil];
        
        
    }
    return self;
}

- (void)setContentOfView:(BOOL)loginState
{
    if (loginState)
    {
        if (USER_MODEL.name != nil) {
            // 已登录
            [self.portraitButton sd_setBackgroundImageWithURL:URL(USER_MODEL.portrait) forState:UIControlStateNormal placeholderImage:Image(@"headIcon_placeholder")];
            
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:USER_MODEL.name];
            NSTextAttachment *imageAttachment = [[NSTextAttachment alloc]init];
            imageAttachment.bounds = CGRectMake(0, -1, 15, 15);
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
            self.nameLabel.attributedText = text;
            self.nameLabel.font = FONT(18);
            self.addTimeLabel.text = [NSString stringWithFormat:@"加入时间：%@",[HelpClass compareCurrentTime:USER_MODEL.joinTime]];
            self.locationLabel.text = [NSString stringWithFormat:@"来自区域：%@ %@",USER_MODEL.province,USER_MODEL.city];
            self.devplatformLabel.text = [NSString stringWithFormat:@"开发平台：%@",USER_MODEL.platforms];
            self.expertiseLabel.text = [NSString stringWithFormat:@"擅长技能：%@",USER_MODEL.expertise];
        }
        
        
    }
    else
    {
        
        
        // 未登录
        [self.portraitButton setBackgroundImage:Image(@"headIcon_placeholder") forState:UIControlStateNormal];
        self.nameLabel.text = @"未登录";
        self.addTimeLabel.text = @"加入时间：";
        self.locationLabel.text = @"来自区域：";
        self.devplatformLabel.text = @"开发平台：";
        self.expertiseLabel.text = @"擅长技能：";
        
    }

}
- (void) clickPortraitAction
{
    if (self.clickHandle != nil)
    {
        self.clickHandle(0);
    }
    
}
- (void) btnAction:(UIButton *)sender
{
    
    if (sender.tag == 413) {
        if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"]) {
            if (self.topScrollView.contentOffset.x == 0) {
                [self.topScrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
            }
            else
            {
                [self.topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            
        }
    }
    
    if (self.clickHandle != nil)
    {
        self.clickHandle(sender.tag);
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
