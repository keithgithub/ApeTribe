//
//  MessageTableView.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "MessageTableView.h"
#import "ImageScrollView.h"
#import "MessageTableViewCell.h"
#import "MessageXmlModel.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation MessageTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        //初始化数组
        self.arrNewsDatas = [NSMutableArray new];
        self.arrScrollImages = [NSMutableArray new];
        self.arrScrollTitles = [NSMutableArray new];
        
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        //初始化滚动视图
//        self.imageScrollView = [[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 100)];
//        self.tableHeaderView = self.imageScrollView;
        
        //注册xib
        UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"MessageCell"];
        
        //添加下拉刷新
        __block MessageTableView *gTableView  = self;
        [self addLegendHeaderWithRefreshingBlock:^{
            [gTableView.gDelegate loadNewsDataWithCurrentPage:0];
        }];
        
        [self addLegendFooterWithRefreshingBlock:^{
            //上提时候要执行的代码
            //判断是否有下一页
            if (gTableView.arrNewsDatas.count>=20)
            {
                gTableView.currentPage++;
                //有下一页
                [gTableView.gDelegate loadNewsDataWithCurrentPage:gTableView.currentPage];
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
    return self.arrNewsDatas.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    [cell setContentCell:self.arrNewsDatas[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageXmlModel *model = self.arrNewsDatas[indexPath.row];

    CGSize size = [model.title boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    if (size.height>42)
    {
        size.height = 42;
    }
    return 80+size.height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageXmlModel *model = self.arrNewsDatas[indexPath.row];
    [self.gDelegate gotoPostDetailVC:model.newsId andType:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
