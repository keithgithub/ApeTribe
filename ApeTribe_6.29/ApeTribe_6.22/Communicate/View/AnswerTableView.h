//
//  AnswerTableView.h
//  OpenSourceChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <UIKit/UIKit.h>
//下拉刷新下载第一页的协议
@protocol AnswerTableViewDelegate <NSObject>
/**
 *  下拉刷新下载第一页的协议
 *
 *  @param page    页码  填写1（下拉刷新）
 */
-(void)loadAnswerDataWithCurrentPage:(long)page;
-(void)didScroll:(CGFloat)y;
-(void)scrollToTop;
-(void)gotoPostDetailVC:(long)Id;
@end
@interface AnswerTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id<AnswerTableViewDelegate> gDelegate;

@property (nonatomic,strong) NSMutableArray *arrAnswerNewDatas;//问答数据
//当前下载页码
@property (nonatomic,assign) long currentPage;
@end
