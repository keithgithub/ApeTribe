//
//  DiscoverTableView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DiscoverTableView.h"

#import "MJRefresh.h"
#import "SVProgressHUD.h"
@implementation DiscoverTableView
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andcellStyle:(DiscoverTableViewCellStyle)cellStyle andTableViewCellBlock:(TableViewCellBlock)tVCellBlock
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.arrData = [NSMutableArray new];
        self.tVCellBlock = tVCellBlock;
        self.delegate =self;
        self.dataSource = self;
        self.cellStyle = cellStyle;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (cellStyle == DiscoverTableViewCellSubtitleStyle)
        {
            
            
            //添加下拉刷新
            __block DiscoverTableView *gTableView = self;
            [self addLegendHeaderWithRefreshingBlock:^{
                
                //下载第一页
                [gTableView.loadDelegat loadGoodsDataWithCurrentPage:0 andTableTag:gTableView.tableTag];
            }];
            //初始化第一页
            gTableView.currentPage = 0;
            //添加上提刷新
            [self addLegendFooterWithRefreshingBlock:^{
                
                //判断是否有下一页
                if ( self.pagesize<20)
                {
                    //最后一页
                    //弹框背景
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                    //设置消失时间
                    [SVProgressHUD setMinimumDismissTimeInterval:1];
                    //设置信息内容
                    [SVProgressHUD showInfoWithStatus:@"已经是最后一页！"];
                    //结束刷新
                    [gTableView.footer endRefreshing];
                    
                }else
                {
                    
                    gTableView.currentPage++;
                    //有下一页
                    [gTableView.loadDelegat loadGoodsDataWithCurrentPage:gTableView.currentPage andTableTag:gTableView.tableTag];
                    
                    
                }
                
            }];
            
        }
        
    }
    return self;
    
}


#pragma mark
#pragma mark TableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark
#pragma mark cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identity = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identity];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identity];
    }
    SoftXMLModel *softModel = self.arrData[indexPath.section];
    cell.textLabel.text = softModel.name;
    
    cell.detailTextLabel.text = softModel.Adescription;
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
#pragma mark
#pragma mark 单元格选中方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoftXMLModel *softXMLModel = self.arrData[indexPath.section];
    
    self.tVCellBlock(softXMLModel);
    
    
}




@end
