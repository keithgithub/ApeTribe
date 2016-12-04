//
//  Function.m
//  4.26标签栏
//
//  Created by ibokan on 16/4/26.
//  Copyright © 2016年 huangfu. All rights reserved.
//

#import "Function.h"
#import "DateModel.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@implementation Function

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnClose = btnClose;
        //设置frame
        btnClose.frame = CGRectMake(self.frame.size.width/2-25, self.frame.size.height-60, 50, 50);
        
        //设置背景图
        [btnClose setBackgroundImage:[UIImage imageNamed:@"XX.png"] forState:UIControlStateNormal];
        btnClose.transform = CGAffineTransformMakeRotation(M_PI_4);
        //添加点击方法
        [btnClose addTarget:self action:@selector(btnCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        //添加毛玻璃效果
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
        
        [self addSubview:effectview];
        //创建一个数组存放图片
        //循环创建按钮
        for (int i=0; i<2; i++) {
            for (int j=0; j<3; j++) {
                //创建按钮
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                //设置坐标及大小
                btn.frame=CGRectMake(20+j*SCREEN_SIZE.width/3, (i*SCREEN_SIZE.width/5)*1.5+SCREEN_SIZE.height/2, SCREEN_SIZE.width/5, SCREEN_SIZE.width/5);
                //添加点击方法
                [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                //设置背景图片
                [btn setBackgroundImage:[UIImage imageNamed:[DateModel getImgName][i*3+j]] forState:UIControlStateNormal];
                //创建文本
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x,(i*SCREEN_SIZE.width/5)*1.5+SCREEN_SIZE.height/2+ SCREEN_SIZE.width/5+5, 60, 20)];
                //设置文本
                lbl.text=[DateModel getTitle][i*3+j];
                //设置字体大小
                lbl.font=[UIFont systemFontOfSize:12];
                //设置中心点
                lbl.center=CGPointMake(btn.center.x, lbl.center.y);
                //lbl.backgroundColor=[UIColor redColor];
                //设置文本布局 居中文本
                lbl.textAlignment=NSTextAlignmentCenter;
                //标记
                btn.tag=100+i*3+j;
                lbl.tag=10+i*3+j;
                
                [self addSubview:btn];
                [self addSubview:lbl];
            }
        }
        
        //显示
        [self addSubview:btnClose];
//        // 设定位置和大小
//        CGRect frame = CGRectMake(SCREEN_SIZE.width/2-187,20,250,200);
//        // 读取gif图片数据
//        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"yuan" ofType:@"gif"]];
//        // view生成
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
//        webView.userInteractionEnabled = NO;//用户不可交互
//        [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//        [self addSubview:webView];
//        
//        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width-80, 25, 21, 200)];
//        lbl.numberOfLines = 0;
//        lbl.text = @"我是个牛逼的程序猿";
//        lbl.textColor = [UIColor colorWithRed:0.913 green:0.000 blue:0.068 alpha:1.000];
//        lbl.font = [UIFont systemFontOfSize:14];
//        [self addSubview:lbl];
     }
    return self;
}

//6个按钮点击方法
-(void)btnAction:(UIButton *)sender
{
    self.btnBlock(sender.tag);
    
    
}

//按钮点击方法
-(void)btnCloseAction:(UIButton *)sender
{
    //[self removeFromSuperview];//移除
    for (int i = 0; i<6; i++)
    {
        
        UIButton *btn=[self viewWithTag:105-i];
        
        UILabel *lbl=[self viewWithTag:15-i];
        [UIView animateWithDuration:0.2 delay:0.02*i options:UIViewAnimationOptionAllowUserInteraction animations:^{
        btn.center = CGPointMake(btn.center.x, self.frame.size.height+60);
        lbl.center = CGPointMake(lbl.center.x, self.frame.size.height+60);
        
    } completion:^(BOOL finished){
        
        [self removeFromSuperview];
        
    }];
   
   }
    
}

@end
