//
//  HomeScrollView.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "HomeScrollView.h"
#import "MTTableView.h"
#import "TweetListXmlModel.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation HomeScrollView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //关闭水平和垂直滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //代理
        self.delegate = self;
        //页码
        self.pagingEnabled = YES;
        
        //当前页码
        self.index = 0;
    }
    return self;
}

//循环创建表格
-(void)setTableViewWithArray:(NSArray *)arrData
{
    //设置内容区大小
    self.contentSize = CGSizeMake(SCREEN_SIZE.width * 3, self.frame.size.height);
    
    //循环创建表格
    for (int i=0; i<3; i++)
    {
        MTTableView * tableView = [[MTTableView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width *i, 0, SCREEN_SIZE.width, self.frame.size.height-49) style:UITableViewStylePlain andTag:i];
        //标记
        self.tag = 100 + i;
        //背景颜色
        tableView.backgroundColor = [UIColor whiteColor];
        //代理
        tableView.Tdelegate = self;
        
        //显示
        [self addSubview:tableView];
    }
}

#pragma ScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.handleBlock(scrollView.contentOffset.x/SCREEN_SIZE.width);
    self.index = scrollView.contentOffset.x/SCREEN_SIZE.width;
    [self refreshTableView:1];
    
}


-(void)selectCellWithDic:(TweetListXmlModel *)model
{
    //回调
    self.callBackBlock(model.tweetListId);
}

//懒加载表格数据数组
-(NSMutableArray *)arrData{
    if (!_arrData)
    {
        _arrData = [NSMutableArray new];
        for (int i=0; i<3; i++)
        {
            NSMutableArray * mArrTV = [NSMutableArray new];
            [_arrData addObject:mArrTV];
        }
    }
    return _arrData;
}

// type=0 下载 1：判断：如果已经有数据，就不去下载
-(void)refreshTableView:(int)type
{
    MTTableView * tableView;
    for (UIView * v in self.subviews)
    {
        if ([v isKindOfClass:[MTTableView class]])
        {
            if ((int)v.tag ==  self.index + 100)
            {
                tableView = (MTTableView *)v;
            }
        }
    }
    int param;
    switch (self.index)
    {
        case 0:
            param = 0;
            break;
        case 1:
            param = -1;
            break;
        case 2:
            param = (int)USER_MODEL.userId;
            break;
        default:
            break;
    }
    [tableView loadTweetListDataWithParam:param andType:type];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
