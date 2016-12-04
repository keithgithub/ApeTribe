//
//  SegmentView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SegmentView.h"

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andTitles:(NSArray *)arrTitles
{
    return [self initWithFrame:frame andIndex:0 andBackgroundColor:backgroundColor andTitles:arrTitles];
}

- (instancetype) initWithFrame:(CGRect)frame andIndex:(int)index andBackgroundColor:(UIColor *) backgroundColor andTitles:(NSArray *)arrTitles
{
    if (self = [super initWithFrame:frame])
    {
        self.bgColor = backgroundColor;
        self.arrTitles = arrTitles;
        self.index = index;
        self.layer.borderColor = backgroundColor.CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        for (int i = 0; i < arrTitles.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(frame.size.width * i / arrTitles.count , 0, frame.size.width / arrTitles.count, frame.size.height);
            [btn setTitle:arrTitles[i] forState:UIControlStateNormal];
            btn.titleLabel.font = FONT(13);
            btn.tag = 200 + i;
            if (i == index)
            {
                btn.backgroundColor = backgroundColor;
                btn.tintColor = [UIColor whiteColor];
            }
            else
            {
                btn.tintColor = backgroundColor;
            }
            
            [self addSubview:btn];
            [btn addTarget:self action:@selector(bntAction:) forControlEvents:UIControlEventTouchUpInside];
            // 添加分割线
            if (i >=1 && i <= 3)
            {
                UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width / arrTitles.count) * i - 0.5, 0, 1, frame.size.height)];
                lineLb.backgroundColor = backgroundColor;
                [self addSubview:lineLb];
            }
            
        }
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

// 点击按钮事件的响应
-(void) bntAction:(UIButton *)sender
{
    if (sender.tag != self.index + 200) {
        self.index = (int)(sender.tag) - 200;
        for (UIView *v in self.subviews)
        {
            if ([v isKindOfClass:[UIButton class]])
            {
                UIButton *btn = (UIButton *)v;
                btn.backgroundColor = [UIColor clearColor];
                btn.tintColor = self.bgColor;
                
            }
        }
        sender.tintColor = [UIColor whiteColor];
        sender.backgroundColor = self.bgColor;
        if (self.clickHandle != nil) {
            self.clickHandle(self.index);
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
