//
//  CommentTableView.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
//下拉刷新下载第一页的协议
@protocol CommentTableViewDelegate <NSObject>
/**
 *  下拉刷新下载第一页的协议
 *
 *  @param page    页码  填写1（下拉刷新）
 */
-(void)loadCommentDataWithCurrentPage:(long)page;

-(void)comeBackWithString:(NSString*)str;
@end
@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id<CommentTableViewDelegate> gDelegate;

@property (nonatomic,strong) NSMutableArray *arrCommentDatas;//评论数据
//当前下载页码
@property (nonatomic,assign) long currentPage;
@end
