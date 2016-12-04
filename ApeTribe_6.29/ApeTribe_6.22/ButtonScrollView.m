//
//  ButtonScrollView.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "ButtonScrollView.h"
#import "Config.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation ButtonScrollView


-(instancetype)initWithFrame:(CGRect)frame andCallBackBlock:(CallBackBlock)handleBlock
{
    if (self = [super initWithFrame:frame])
    {
        self.callBackBlock = handleBlock;
        self.backgroundColor = [UIColor colorWithWhite:0.950 alpha:1.000];
        //关闭水平和垂直的滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.contentSize = CGSizeMake(SCREEN_SIZE.width, self.frame.size.height);
        self.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
        //获取按钮标题
        self.arrTitles = @[@"新鲜漫谈",@"最热漫谈",@"我的漫谈"];
        //循环创建按钮
        for (int i=0; i<self.arrTitles.count; i++)
        {
            //创建按钮对象
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //大小
            btn.frame = CGRectMake(SCREEN_SIZE.width/3*i, 0, SCREEN_SIZE.width/3, 38);
            //标题
            [btn setTitle:self.arrTitles[i] forState:UIControlStateNormal];
            //判断
            if (i == 0)
            {
                //标题的颜色是绿色
                btn.tintColor = COLOR_FONT_D_GREEN;
            }
            else
            {
                btn.tintColor = COLOR_FONT_L_GRAY;
            }
            //设置按钮的标记
            btn.tag = 100+i;
            //设置按钮点击响应方法
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            //显示
            [self addSubview:btn];
        }
        [self createMoveView];
    }
    return self;
}

//滑动条
-(void)createMoveView
{
    //创建滑动条底部视图
    self.moveView = [[UIView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_SIZE.width/3, 2)];
    //创建滑动条
    UIView * moveSmallView = [[UIView alloc]initWithFrame:CGRectMake(self.moveView.frame.size.width/2-36, 0, 72, 2)];
    
    //背景颜色
    moveSmallView.backgroundColor = COLOR_FONT_D_GREEN;
    //显示
    [self.moveView addSubview:moveSmallView];
    //显示
    [self addSubview:self.moveView];
}


//按钮响应
-(void)btnAction:(UIButton *)sender
{
    int index = (int)(sender.tag - 100);
    self.callBackBlock(index);
    [self changeButtonState:index];
}

-(void)changeButtonState:(NSInteger)currentPage
{
    
    //未选中时为灰色
    NSArray * btnSubViews = self.subviews;
    
    for (int i=0; i<btnSubViews.count; i++)
    {
        //获取每一个子视图
        UIView * v = btnSubViews[i];
        //判断
        if (v.tag >=100 && v.tag <103 )
        {
            //数据强转
            UIButton * btn = (UIButton *)v;
            //3个按钮全部变为灰色
            btn.tintColor = COLOR_FONT_L_GRAY;
            btn.transform=CGAffineTransformMakeScale(1, 1);
        }
    }
    
    //获取所有子视图
    NSArray *subViewsBtn=[self subviews];
    for (int i=0; i<subViewsBtn.count; i++)
    {
        //获取每一个子视图
        UIView *v=subViewsBtn[i];
        
        if (v.tag==currentPage+100)
        {
            UIButton *btn=(UIButton *)v;//做数据强转
            [UIView animateWithDuration:0.2 animations:^{
                btn.tintColor=COLOR_FONT_D_GREEN;
                btn.transform=CGAffineTransformMakeScale(1.15, 1.15);
                CGRect frame=self.moveView.frame;
                frame.origin.x=currentPage*self.moveView.frame.size.width;
                self.moveView.frame=frame;
            }];
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
