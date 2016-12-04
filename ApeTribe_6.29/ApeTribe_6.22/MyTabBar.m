//
//  MyTabBar.m
//  UITabbarController_4.26_1
//
//  Created by ibokan on 16/4/26.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MyTabBar.h"
#import "Tool.h"
@implementation MyTabBar
-(instancetype)init
{
    if (self = [super init])
    {
        // 创建按钮
        self.btnCenter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        // 创建frame
        self.btnCenter.frame = CGRectMake(0, 0, 45, 45);
        // 添加背景图片
        [self.btnCenter setBackgroundImage:[Tool getRendingImageWithName:@"saoyisao"] forState:UIControlStateNormal];
        
        
        // 添加点击事件
        [self.btnCenter addTarget:self action:@selector(btnCenterAction) forControlEvents:UIControlEventTouchUpInside];
        // 添加到标签栏上面
        [self addSubview:self.btnCenter];
    }
    return self;
}
// 实现按钮的点击方法
-(void)btnCenterAction
{
    // 判断方法是否可以执行
    if ([self.tDelegate respondsToSelector:@selector(sendMsg)])
    {
        // 调用代理方法
        [self.tDelegate sendMsg];
    }
    
}
// 只要self上的子视图的大小位置发生变化，就自动调用这个方法
-(void)layoutSubviews
{
    // 先用super调用父类的方法
    [super layoutSubviews];
    // 按钮在标签栏中间
    self.btnCenter.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    // 计算每个按钮的宽度
    CGFloat w = self.frame.size.width / 5;
    // 定义一个索引获取标签栏按钮
    int i = 0;
    for (UIView *view in self.subviews)
    {
        // 判断view是否是UITabBarButton
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            view.frame = CGRectMake(i * w, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            // 计算
            i++;
            if (i == 2)// 改完前两个，第三个跳过
            {
                i++;// 跳过第三个
            }
            
        }
        NSLog(@"%@",view);
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













