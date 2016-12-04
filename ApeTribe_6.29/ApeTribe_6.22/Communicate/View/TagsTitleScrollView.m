//
//  TagsTitleScrollView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TagsTitleScrollView.h"
#import "TitleScrollView.h"
#import "Config.h"
#define TITLE_HIGHT frame.size.height
#define TITLE_COLOR [UIColor colorWithRed:0.917 green:1.000 blue:0.912 alpha:1.000]
#define TITLE_COLOR_CLICK [UIColor colorWithRed:0.176 green:0.729 blue:0.412 alpha:1.000]
#define TITLE_COLOR_BACKGROUND [UIColor colorWithRed:0.042 green:0.695 blue:0.155 alpha:1.000]
#define TITLE_FONT [UIFont systemFontOfSize:15]
#define TITLE_FONT_CLICK [UIFont systemFontOfSize:19]
#define VIEW_WIDTH self.frame.size.width
@implementation TagsTitleScrollView
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)tags
{
    if (self = [super initWithFrame:frame])
    {
        self.showsVerticalScrollIndicator = NO;//隐藏垂直线
        self.showsHorizontalScrollIndicator = NO;//隐藏水平线
        
        
        //数组赋值
        self.arrTitle = tags;
        
        //标题个数
        long count = tags.count;
        
        self.contentSizeWidth = 0;
        
        
        //按钮背景scrollView的一些属性赋值
        self.scrollEnabled = YES;
        self.contentSize = CGSizeMake(self.contentSizeWidth, TITLE_HIGHT);
        
        //循环创建按钮
        for (int i = 0; i<count; i++)
        {
            CGSize textSize = [tags[i] sizeWithAttributes:@{NSFontAttributeName:TITLE_FONT}];
            
            //获取按钮的真实宽度
            CGFloat btnWidth = textSize.width+20;
            
            //创建按钮
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.contentSizeWidth+5*i, 0, btnWidth, TITLE_HIGHT)];
            btn.tag = 11+i;
            
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor grayColor].CGColor;
            
            //设置按钮属性
            btn.backgroundColor  =  TITLE_COLOR_BACKGROUND;
            [btn setTitle:tags[i] forState:UIControlStateNormal];
            
            btn.titleLabel.font = TITLE_FONT;
            [btn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(btnActiton:) forControlEvents:UIControlEventTouchUpInside];
            
            self.contentSizeWidth = self.contentSizeWidth+btnWidth;
            
            //添加到滚动视图
            [self addSubview:btn];
        }
        //设置滚动视图属性
        self.contentSize = CGSizeMake(self.contentSizeWidth,TITLE_HIGHT);
        
        
    }
    return self;
}


-(void)btnActiton:(UIButton*)sender
{
    [self.gDelegate sendMessageWithTag:self.arrTitle[sender.tag-11]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
