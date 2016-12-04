//
//  MTTableView.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTableViewCell.h"


@protocol MTTableViewDelegate <NSObject>

-(void)selectCellWithDic:(NSDictionary *)dic;

@end

@interface MTTableView : UITableView

<UITableViewDataSource,UITableViewDelegate>

//漫谈数据
@property(nonatomic,strong)NSMutableArray * arrData;

//单元格
@property(nonatomic,strong)MTTableViewCell *cell;

//代理
@property(nonatomic,assign)id<MTTableViewDelegate>Tdelegate;

@property(nonatomic,assign)long tweetID;

//页码
@property(nonatomic,assign)int page;

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andTag:(int)tag;

//下载数据
-(void)loadTweetListDataWithParam:(int)paramInt andType:(int)type;

@end
