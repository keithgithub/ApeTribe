//
//  TitleScrollView.h
//  OpenSourceChina
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TitleScrollViewDelegate <NSObject>


@optional
//给代理传递标记然后，根据标记下载数据
-(void)sendMessageWithTag:(long)tag;
-(void)changgeContenOffSizeWithTag:(NSInteger)tag;

@end

@interface TitleScrollView : UIScrollView
@property (nonatomic,assign) id<TitleScrollViewDelegate>gDelegate;

@property (nonatomic,strong) NSArray *arrTitle;//标题

@property (nonatomic,strong) UIView *moveView;

@property (nonatomic,assign) CGFloat contentSizeWidth;//滚动视图的滚动范围
//初始化



-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)arrTitle;

@end

