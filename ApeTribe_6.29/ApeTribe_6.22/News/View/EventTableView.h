//
//  EventTableView.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageScrollView;
//下拉刷新下载第一页的协议
@protocol EventTableViewDelegate <NSObject>
/**
 *  下拉刷新下载第一页的协议
 *
 *  @param page    页码  填写1（下拉刷新）
 */
-(void)loadEventDataWithCurrentPage:(long)page;
-(void)gotoPostDetailVC:(long)Id andType:(long)type;
@end

@interface EventTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id<EventTableViewDelegate> gDelegate;

@property (nonatomic,strong) ImageScrollView *imageScrollView;

@property (nonatomic,strong) NSMutableArray *arrEventDatas;//活动数据
//当前下载页码
@property (nonatomic,assign) long currentPage;
@end
