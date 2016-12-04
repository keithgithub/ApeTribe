//
//  MTTableView.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "MTTableView.h"
#import "DetailViewController.h"
#import "AFHTTPRequestOperationManager+Util.h"
#import "Ono.h"
#import "URL.h"
#import "TweetListXmlModel.h"
#import "LoadModel.h"
#import "MJRefresh.h"
#import "MBProgressHUD+NJ.h"

@implementation MTTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andTag:(int)tag
{
    if (self = [super initWithFrame:frame style:style])
    {
        //初始化
        self.arrData = [NSMutableArray new];
        
        //Nib
        [self registerNib:[UINib nibWithNibName:@"MTTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        //代理
        self.dataSource = self;
        self.delegate = self;
        //表格线
        self.separatorStyle = NO;
        
        
        
        //初始化页码
        self.page = 0;
        
        //判断
        int param = 0;
        switch (tag)
        {
            case 0:
            {
                param = 0;
                __weak typeof(self)weakSelf = self;
                [self addLegendHeaderWithRefreshingBlock:^{
                    [weakSelf.footer setState:MJRefreshFooterStateRefreshing];
                    weakSelf.page = 0;
                    [weakSelf loadTweetListDataWithParam:param andType:0];
                    [weakSelf.header endRefreshing];
                }];
                
                [self addLegendFooterWithRefreshingBlock:^{
                    weakSelf.page++;
                    [weakSelf loadTweetListDataWithParam:param andType:0];
                    [weakSelf.footer endRefreshing];
                }];
            }
                break;
                
            case 1:
            {
                param = -1;
                __weak typeof(self)weakSelf = self;
                [self addLegendHeaderWithRefreshingBlock:^{
                    [weakSelf.header beginRefreshing];
                    [weakSelf.footer setState:MJRefreshFooterStateRefreshing];
                    weakSelf.page = 0;
                    [weakSelf loadTweetListDataWithParam:param andType:0];
                    [weakSelf.header endRefreshing];
                }];
                
                [self addLegendFooterWithRefreshingBlock:^{
                    weakSelf.page++;
                    [weakSelf loadTweetListDataWithParam:param andType:0];
                    [weakSelf.footer endRefreshing];
                }];
            }

                break;
                
            case 2:
            {
                param = (int)USER_MODEL.userId;
                __weak typeof(self)weakSelf = self;
                [self addLegendHeaderWithRefreshingBlock:^{
                    [weakSelf.header beginRefreshing];
                    [weakSelf.footer setState:MJRefreshFooterStateRefreshing];
                    weakSelf.page = 0;
                    [weakSelf loadTweetListDataWithParam:param andType:0];
                    [weakSelf.header endRefreshing];
                }];
                
                [self addLegendFooterWithRefreshingBlock:^{
                    weakSelf.page++;
                    [weakSelf loadTweetListDataWithParam:param andType:0];
                    [weakSelf.footer endRefreshing];
                }];

            }
                break;
            default:
                break;
        }
   
        //漫谈数据
        [self loadTweetListDataWithParam:param andType:0];
        
    }
    return self;
}

#pragma mark 表格代理

//单元格数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

//单元格样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_cell == nil)
    {
        _cell = [[MTTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [_cell setCell:self.arrData[indexPath.row]];
    
    return _cell;
}

//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = self.cell.tempH+80;
    return h;
}

//选中跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.Tdelegate selectCellWithDic:self.arrData[indexPath.row]];
}

#pragma end mark











//下载漫谈列表数据
-(void)loadTweetListDataWithParam:(int)paramInt andType:(int)type
{
    if (type == 1) {
        if (self.arrData.count != 0) {
            return;
        }
    }
    
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_LIST];

    [LoadModel postRequestWithUrl:strURL andParams:PARAM_TWEET_LIST(@(paramInt), 20, self.page) andSucBlock:^(id responseObject) {
       
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement * result = obj.rootElement;
        
        
        NSArray * arrTweetList = [[result firstChildWithTag:@"tweets"]childrenWithTag:@"tweet"];
        
        if (self.page ==0) {
            [self.arrData removeAllObjects];
        }
        
        for (ONOXMLElement * objXml in arrTweetList)
        {
            TweetListXmlModel * tweetListModel = [TweetListXmlModel tweetListXmlModelWithXml:objXml];
            [self.arrData addObject:tweetListModel];
        }
        
        
        if (self.arrData.count<(self.page+1)*20) {
            //无更多数据
            [self.footer setState:MJRefreshFooterStateNoMoreData];
        }

        
        //刷新表格
        [self reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
    
}


//删除漫谈
-(void)deleteTweetAction
{
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_DELETE];
    
    [LoadModel postRequestWithUrl:strURL andParams:PARAM_TWEET_DELETE(USER_MODEL.userId, self.tweetID) andSucBlock:^(id responseObject) {
        
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement * result = obj.rootElement;
        
        //错误编号
        NSInteger errorCode = [[[result firstChildWithTag:@"errorCode"]numberValue]integerValue];
        //错误信息
        NSString *errorMessage = [[result firstChildWithTag:@"errormessage"]stringValue];
        
        if (errorCode == 1)
        {
            NSString *err = [NSString stringWithFormat:@"%@", errorMessage];
            [MBProgressHUD showError:err];
        }
        else
        {
            [MBProgressHUD showSuccess:@"删除成功！"];
        }

        
    } andFailBlock:^(NSError *error) {
        
    }];
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
