//
//  AnswerTableView.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "AnswerTableView.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "AnswerTableViewCell.h"
#import "AnswerXmlModel.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation AnswerTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        //初始化数组
        self.arrAnswerNewDatas = [NSMutableArray new];
        //设置代理
        self.dataSource = self;
        self.delegate = self;
                
        //注册xib
        UINib *nib = [UINib nibWithNibName:@"AnswerTableViewCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"AnswerCell"];
        
        
        //添加下拉刷新
        __block AnswerTableView *gTableView  = self;
        [self addLegendHeaderWithRefreshingBlock:^{
            [gTableView.gDelegate loadAnswerDataWithCurrentPage:0];
        }];
        
        [self addLegendFooterWithRefreshingBlock:^{
            //上提时候要执行的代码
            //判断是否有下一页
            if (gTableView.arrAnswerNewDatas.count>=20)
            {
                gTableView.currentPage++;
                //有下一页
                [gTableView.gDelegate loadAnswerDataWithCurrentPage:gTableView.currentPage];
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
    return self.arrAnswerNewDatas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell" forIndexPath:indexPath];
    [cell setContentCell:self.arrAnswerNewDatas[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerXmlModel *model = self.arrAnswerNewDatas[indexPath.row];
    
    CGSize size = [model.title boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    if (size.height>42)
    {
        size.height = 42;
    }
    return 95+size.height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AnswerXmlModel *model = self.arrAnswerNewDatas[indexPath.row];
    [self.gDelegate gotoPostDetailVC:model.answerId];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    [self.gDelegate didScroll:y];
}
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    [self.gDelegate scrollToTop];
}


@end
