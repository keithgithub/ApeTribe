//
//  BloggerTableView.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
//下拉刷新下载第一页的协议
@protocol BloggerTableViewDelegate <NSObject>
/**
 *  下拉刷新下载第一页的协议
 *
 *  @param page    页码  填写1（下拉刷新）
 */
-(void)loadBloggerDataWithCurrentPage:(long)page;
-(void)gotoPostDetailVC:(long)Id andType:(long)type;
@end

@interface BloggerTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id<BloggerTableViewDelegate> gDelegate;

@property (nonatomic,strong) NSMutableArray *arrBloggerHotDatas;//博客最热数据
@property (nonatomic,strong) NSMutableArray *arrBloggerNewDatas;//博客最新数据
//当前下载页码
@property (nonatomic,assign) long currentPage;


@end
