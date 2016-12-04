//
//  SynthesizeView.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/26.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleScrollView;
@class MessageTableView;
@class BloggerTableView;
@class EventTableView;

@protocol SynthesizeViewDelegate <NSObject>
//给代理传递标记然后，根据标记下载数据
-(void)sendMessageWithTag:(long)tag;
@end

@interface SynthesizeView : UIView<UIScrollViewDelegate>


@property (nonatomic,strong) TitleScrollView *titleView;
@property (nonatomic,strong) MessageTableView *messageTableView;//表格
@property (nonatomic,strong) BloggerTableView *bloggerTableView;
@property (nonatomic,strong) EventTableView *eventTableView;
@property (nonatomic,strong) UIScrollView *scrollView;


@property (nonatomic,assign) id<SynthesizeViewDelegate> gDelegate;
@property (nonatomic,strong) NSMutableArray *mArrNewsDatas;//资讯数据
@property (nonatomic,strong) NSMutableArray *mArrBloggerNewDatas;//博客最新数据
@property (nonatomic,strong) NSMutableArray *mArrBloggerHotDatas;//博客推荐数据
@property (nonatomic,strong) NSMutableArray *mArrEvenrDatas;//活动详细数据
@property (nonatomic,strong) NSMutableArray *mArrEvent;//活动列表数据
@property (nonatomic,assign) int currentPage;
//试着滚动视图的滚动范围
-(void)setContentWithIndex:(int)index;

-(void)setNewsData:(NSMutableArray*)mArr;
-(void)setBloggerNewData:(NSMutableArray*)mArr;
-(void)setBloggerHotData:(NSMutableArray*)mArr;
-(void)setEventData:(NSMutableArray*)mArr;


@end
