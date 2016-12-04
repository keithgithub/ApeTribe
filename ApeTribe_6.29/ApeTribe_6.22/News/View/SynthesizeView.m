//
//  SynthesizeView.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/26.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "SynthesizeView.h"
#import "TitleScrollView.h"
#import "MessageTableView.h"
#import "BloggerTableView.h"
#import "EventTableView.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCROLLVIEW_SIZE self.scrollView.frame.size

#define TITLE_COLOR [UIColor colorWithRed:0.457 green:0.500 blue:0.452 alpha:1.000]
#define TITLE_COLOR_CLICK [UIColor colorWithRed:0.047 green:0.596 blue:0.015 alpha:1.000]
#define TITLE_FONT [UIFont systemFontOfSize:15]
#define TITLE_FONT_CLICK [UIFont systemFontOfSize:19]
@interface SynthesizeView ()<TitleScrollViewDelegate>


@end
@implementation SynthesizeView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化数组
        self.mArrNewsDatas = [NSMutableArray new];
        self.mArrBloggerHotDatas = [NSMutableArray new];
        self.mArrBloggerNewDatas = [NSMutableArray new];
        self.mArrEvent = [NSMutableArray new];
        
        self.titleView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 40) andTitle:@[@"资讯",@"博客",@"活动"]];
        self.titleView.gDelegate = self;
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_SIZE.width, SCREEN_SIZE.height-40)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        
        self.scrollView.delegate = self;
        
        //显示
        [self addSubview:self.titleView];
        [self addSubview:self.scrollView];
    }
    return self;
}

-(void)setContentWithIndex:(int)index
{
    self.scrollView.contentSize = CGSizeMake(3*SCREEN_SIZE.width, self.scrollView.frame.size.height-40);
    
    if (index == 0)
    {
        [self.scrollView addSubview:self.messageTableView];
    }
    else if(index == 1)
    {
        [self.scrollView addSubview:self.bloggerTableView];
    }
    else
    {
        [self.scrollView addSubview:self.eventTableView];
    }
}


/**
 *  停止的时候的时候调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPage = self.scrollView.contentOffset.x/SCREEN_SIZE.width;
    NSLog(@"%@",self.titleView);
    UIButton *btn = [self.titleView viewWithTag:(11+self.currentPage)];
    
    [self.gDelegate sendMessageWithTag:self.currentPage];

    //获取子视图
    NSArray *views = self.titleView.subviews;
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

    //这个时候有一个滑动的效果
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleView.moveView.frame = CGRectMake(btn.frame.origin.x+5, btn.frame.size.height-2, btn.frame.size.width-10, 2);
        btn.titleLabel.font = TITLE_FONT_CLICK;
    } completion:nil];
    [btn setTitleColor:TITLE_COLOR_CLICK forState:UIControlStateNormal];
    

}

//懒加载活动表格视图
-(EventTableView*)eventTableView
{
    if (_eventTableView == nil)
    {
        _eventTableView = [[EventTableView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width*2, 0, SCREEN_SIZE.width, SCROLLVIEW_SIZE.height) style:UITableViewStylePlain];
        
    }
    
    return _eventTableView;
}
//懒加载咨询表格视图
-(MessageTableView*)messageTableView
{
    if (_messageTableView == nil)
    {
        _messageTableView = [[MessageTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCROLLVIEW_SIZE.height) style:UITableViewStylePlain];
    }
    
    return _messageTableView;
}
//懒加载博客表格视图
-(BloggerTableView*)bloggerTableView
{
    if (_bloggerTableView == nil)
    {
        _bloggerTableView = [[BloggerTableView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, SCROLLVIEW_SIZE.height) style:UITableViewStylePlain];
    }
    
    return _bloggerTableView;
}

@end
