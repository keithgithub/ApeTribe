//
//  MyTabBar.h
//  UITabbarController_4.26_1
//
//  Created by ibokan on 16/4/26.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTabBarDelegate <NSObject>

-(void)sendMsg;// 点击按钮会执行的方法

@end

@interface MyTabBar : UITabBar
// 标签栏中间的按钮
@property(nonatomic,strong)UIButton *btnCenter;
// 创建代理属性
@property(nonatomic,assign)id<MyTabBarDelegate> tDelegate;



@end
