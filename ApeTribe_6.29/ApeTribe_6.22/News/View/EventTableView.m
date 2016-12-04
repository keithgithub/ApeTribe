//
//  EventTableView.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "EventTableView.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "EventTableViewCell.h"
#import "ImageScrollView.h"
#import "EventXmlModel.h"
@implementation EventTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        //初始化数组
        self.arrEventDatas = [NSMutableArray new];
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        //初始化滚动视图
//        self.imageScrollView = [[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 160)];
//        self.tableHeaderView = self.imageScrollView;
        
        //注册xib
        UINib *nib = [UINib nibWithNibName:@"EventTableViewCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"EventCell"];
        
        //添加下拉刷新
        __block EventTableView *gTableView  = self;
        [self addLegendHeaderWithRefreshingBlock:^{
            [gTableView.gDelegate loadEventDataWithCurrentPage:0];
        }];
        
        [self addLegendFooterWithRefreshingBlock:^{
            //上提时候要执行的代码
            //判断是否有下一页
            if (gTableView.arrEventDatas.count>=20)
            {
                gTableView.currentPage++;
                //有下一页
                [gTableView.gDelegate loadEventDataWithCurrentPage:gTableView.currentPage];
            }
            else
            {
                [gTableView.footer setState:MJRefreshFooterStateNoMoreData];            
            }
        }];
        
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrEventDatas.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    if (self.arrEventDatas.count > 0)
    {
        [cell setContentCell:self.arrEventDatas[indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EventXmlModel *model = self.arrEventDatas[indexPath.row];
    [self.gDelegate gotoPostDetailVC:model.eventId andType:2];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end
