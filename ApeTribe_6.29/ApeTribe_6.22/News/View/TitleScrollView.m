//
//  TitleScrollView.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "TitleScrollView.h"
#import "Config.h"
#define TITLE_HIGHT frame.size.height
#define TITLE_COLOR [UIColor colorWithRed:0.457 green:0.500 blue:0.452 alpha:1.000]
#define TITLE_COLOR_CLICK [UIColor colorWithRed:0.176 green:0.729 blue:0.412 alpha:1.000]
#define TITLE_COLOR_BACKGROUND [UIColor colorWithWhite:0.947 alpha:1.000]
#define TITLE_FONT [UIFont systemFontOfSize:15]
#define TITLE_FONT_CLICK [UIFont systemFontOfSize:19]
#define VIEW_WIDTH self.frame.size.width
#define MOVE_VIEW_COLOR [UIColor colorWithRed:1.000 green:0.512 blue:0.084 alpha:1.000]

@implementation TitleScrollView
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)arrTitle
{
    if (self = [super initWithFrame:frame])
    {
        self.showsVerticalScrollIndicator = NO;//隐藏垂直线
        self.showsHorizontalScrollIndicator = NO;//隐藏水平线
        
        //数组赋值
        self.arrTitle = arrTitle;
        
        //标题个数
        long count = arrTitle.count;
        //判断标题个数
        if (count <=5)
        {
            //按钮背景scrollView的一些属性赋值
            self.scrollEnabled = NO;
            self.contentSize = CGSizeMake(frame.size.width*count, TITLE_HIGHT);
            
            //按钮的宽度
            CGFloat width = frame.size.width/count;
            
            //循环创建按钮
            for (int i = 0; i<count; i++)
            {
                //创建按钮，并设置一些属性
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn.frame = CGRectMake(i*width, 0, width, TITLE_HIGHT);
                [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
                btn.backgroundColor = TITLE_COLOR_BACKGROUND;
                if (i == 0)
                {
                    [btn setTitleColor:TITLE_COLOR_CLICK  forState:UIControlStateNormal];
                    btn.titleLabel.font = TITLE_FONT_CLICK;
                }
                else
                {
                    btn.titleLabel.font = TITLE_FONT;
                    [btn setTitleColor:TITLE_COLOR  forState:UIControlStateNormal];
                }
                btn.tag = 11+i;
                //给按钮添加事件
                [btn addTarget:self action:@selector(btnActiton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                //显示滚动条
                [self addSubview:self.moveView];
            }
        }
        else
        {
            //单个按钮的长度
            CGSize textSize = [arrTitle[0] sizeWithAttributes:@{NSFontAttributeName:TITLE_FONT}];
            
            self.moveView = [[UIView alloc]initWithFrame:CGRectMake(0, TITLE_HIGHT-2, textSize.width+30, 2)];
            self.moveView.backgroundColor = [UIColor colorWithRed:0.992 green:0.660 blue:0.107 alpha:1.000] ;
            
            long count = arrTitle.count;
            double contentSizeWidth = 0;
            //循环创建按钮
            for (int i = 0; i<count; i++)
            {
                CGSize textSize = [arrTitle[i] sizeWithAttributes:@{NSFontAttributeName:TITLE_FONT}];
                
                //获取按钮的真实宽度
                CGFloat btnWidth = textSize.width+30;
                
                //创建按钮
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(contentSizeWidth, 0, btnWidth, TITLE_HIGHT)];
                btn.tag = 11+i;
                
                //设置按钮属性
                btn.backgroundColor  =  TITLE_COLOR_BACKGROUND;
                [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
                
                if (i == 0)
                {
                    [btn setTitleColor:TITLE_COLOR_CLICK forState:UIControlStateNormal];
                    btn.titleLabel.font = TITLE_FONT_CLICK;
                }
                else
                {
                    btn.titleLabel.font = TITLE_FONT;
                    [btn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
                }
                
                [btn addTarget:self action:@selector(btnActiton:) forControlEvents:UIControlEventTouchUpInside];
                
                contentSizeWidth = contentSizeWidth+btnWidth;
                
                //添加到滚动视图
                [self addSubview:btn];
            }
            self.contentSizeWidth = contentSizeWidth;
            //设置滚动视图属性
            self.contentSize = CGSizeMake(contentSizeWidth,TITLE_HIGHT);
            //显示滚动条
            [self addSubview:self.moveView];

        }
    }
    return self;
}


-(void)btnActiton:(UIButton*)sender
{
    
    [self.gDelegate sendMessageWithTag:sender.tag-11];
    [self.gDelegate changgeContenOffSizeWithTag:sender.tag];

    //获取子视图
    NSArray *views = self.subviews;
    for (UIView *view in views)
    {
        //设置为没有点击和选中的颜色
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton*)view;
            [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            button.titleLabel.font = TITLE_FONT;
        }
    }
    
    if (self.arrTitle.count <= 5)
    {
        sender.titleLabel.font = TITLE_FONT_CLICK;
        [sender setTitleColor:TITLE_COLOR_CLICK forState:UIControlStateNormal];
    }
    else
    {
        //这个时候有一个滑动的效果
        [UIView animateWithDuration:0.25 animations:^{
            if (sender.center.x>VIEW_WIDTH/2)
            {
                if ((self.contentSizeWidth - sender.frame.origin.x) < VIEW_WIDTH/2)
                {
                    self.contentOffset = CGPointMake(self.contentSizeWidth-VIEW_WIDTH, 0);
                }
                else
                {
                    self.contentOffset = CGPointMake(sender.center.x-VIEW_WIDTH/2, 0);
                }
            }
            else
            {
                self.contentOffset = CGPointMake(0, 0);
            }
            
            
            self.moveView.frame = CGRectMake(sender.frame.origin.x+5, sender.frame.size.height-2, sender.frame.size.width-10, 2);
            sender.titleLabel.font = TITLE_FONT_CLICK;
        } completion:nil];
        [sender setTitleColor:TITLE_COLOR_CLICK forState:UIControlStateNormal];
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
