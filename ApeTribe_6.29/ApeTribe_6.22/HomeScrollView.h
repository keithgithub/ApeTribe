//
//  HomeScrollView.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTableView.h"
#import "TweetListXmlModel.h"

//滚动视图代码块
typedef void(^ScrollViewBlock)(NSInteger currentPage);

//回调代码块
typedef void(^TableCallBackBlock)(long ID);


@interface HomeScrollView : UIScrollView<UIScrollViewDelegate,MTTableViewDelegate>

@property(nonatomic,strong)ScrollViewBlock handleBlock;
@property(nonatomic,strong)TableCallBackBlock callBackBlock;

//标记
@property(nonatomic,assign)int index;

//存放表格数据数组
@property(nonatomic,strong)NSMutableArray * arrData;

@property(nonatomic,assign)int page;

-(void)setTableViewWithArray:(NSArray *)arrData;

-(void)refreshTableView:(int)type;



@end
