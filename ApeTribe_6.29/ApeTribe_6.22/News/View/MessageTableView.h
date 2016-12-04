//
//  MessageTableView.h
//  OpenSourceChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageScrollView;

//下拉刷新下载第一页的协议
@protocol MessageTableViewDelegate <NSObject>
/**
 *  下拉刷新下载第一页的协议
 *
 *  @param page    页码  填写1（下拉刷新）
 */
-(void)loadNewsDataWithCurrentPage:(long)page;
-(void)gotoPostDetailVC:(long)Id andType:(long)type;
@end

@interface MessageTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id<MessageTableViewDelegate> gDelegate;
@property (nonatomic,strong) NSMutableArray *arrScrollImages;//滚动图片
@property (nonatomic,strong) NSMutableArray *arrScrollTitles;//滚动标题
@property (nonatomic,strong) NSMutableArray *arrNewsDatas;//新闻数据
@property (nonatomic,strong) ImageScrollView *imageScrollView;//滚动视图对象

//当前下载页码
@property (nonatomic,assign) long currentPage;


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andImages:(NSArray*)arrImages andTitles:(NSArray*)arrTitles andNewsData:(NSArray*)arrNewsData;

@end
