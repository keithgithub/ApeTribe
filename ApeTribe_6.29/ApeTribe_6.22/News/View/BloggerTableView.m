//
//  BloggerTableView.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "BloggerTableView.h"
#import "BloggerTableViewCell.h"
#import "BloggerXmlModel.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "BloggerXmlModel.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation BloggerTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        //初始化数组
        self.arrBloggerHotDatas = [NSMutableArray new];
        self.arrBloggerNewDatas = [NSMutableArray new];
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        
        //注册xib
        UINib *nib = [UINib nibWithNibName:@"BloggerTableViewCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"BloggerCell"];
        
        //添加下拉刷新
        __block BloggerTableView *gTableView  = self;
        [self addLegendHeaderWithRefreshingBlock:^{
            [gTableView.gDelegate loadBloggerDataWithCurrentPage:0];
        }];
        
        [self addLegendFooterWithRefreshingBlock:^{
            //上提时候要执行的代码
            //判断是否有下一页
            if ((gTableView.arrBloggerHotDatas.count + gTableView.arrBloggerNewDatas.count)>=20)
            {
                gTableView.currentPage++;
                //有下一页
                [gTableView.gDelegate loadBloggerDataWithCurrentPage:gTableView.currentPage];
            }
            else
            {
                [gTableView.footer setState:MJRefreshFooterStateNoMoreData];

            }
        }];
        
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.arrBloggerHotDatas.count;
    }
    else
    {
        return self.arrBloggerNewDatas.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     BloggerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BloggerCell" forIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        [cell setContentCell:self.arrBloggerHotDatas[indexPath.row] andStyle:0];
    }
    else
    {
        [cell setContentCell:self.arrBloggerNewDatas[indexPath.row] andStyle:1];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        BloggerXmlModel *model = self.arrBloggerHotDatas[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"    %@",model.title];
        CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        if (size.height>42)
        {
            size.height = 42;
        }
        return 95+size.height;
    }
    else
    {
        BloggerXmlModel *model = self.arrBloggerNewDatas[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"  %@",model.title];
        CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        if (size.height>42)
        {
            size.height = 42;
        }
        return 95+size.height;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"最热";
    }
    else
    {
        return @"最新";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        BloggerXmlModel *model = self.arrBloggerHotDatas[indexPath.row];
        [self.gDelegate gotoPostDetailVC:model.bloggerId andType:1];
    }
    else
    {
        BloggerXmlModel *model = self.arrBloggerNewDatas[indexPath.row];
        [self.gDelegate gotoPostDetailVC:model.bloggerId andType:1];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
