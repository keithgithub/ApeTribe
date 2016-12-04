//
//  ZanViewController.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "ZanViewController.h"
#import "ZanTableViewCell.h"
#import "TweetLikeListXmlModel.h"
#import "TweetListXmlModel.h"
#import "TweetLikeListXmlModel.h"
#import "TweetDetailXmlModel.h"
#import "AFHTTPRequestOperationManager+Util.h"
#import "Ono.h"
#import "URL.h"
#import "LoadModel.h"
#import "MJRefresh.h"

@interface ZanViewController ()
//协议
<UITableViewDataSource,UITableViewDelegate>

//漫谈详情
@property(nonatomic,strong)TweetListXmlModel * tweetList;
//点赞列表
@property(nonatomic,strong)TweetLikeListXmlModel * tweetLikeList;
//@property(nonatomic,strong)TweetDetailXmlModel * tweetDetail;

//页码
@property(nonatomic,assign)int page;

//表格
@property(nonatomic,strong)UITableView * tableView;

//数据
@property(nonatomic,strong)NSMutableArray * arrData;

@end

@implementation ZanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"点赞列表";
    
    //导航栏左侧返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_pressed"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"topbar_back_normal"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    //初始化页码
    _page = 0;
    
    //创建表格
    [self createTableView];

    //初始化数组
    self.arrData = [NSMutableArray new];
    
    //下载点赞列表数据
    [self loadLikeListData:self.page];
    
    //下拉与上提刷新
    [self addRefreshAction];
    
}


//创建表格
-(void)createTableView
{
    //创建表格
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //取消表格的线
    self.tableView.separatorStyle = NO;
    //背景颜色
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //显示
    [self.view addSubview:self.tableView];
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
    //单元格
    ZanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[ZanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //设置内容
    [cell setCell:self.arrData[indexPath.row]];
    
    return cell;
}

//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma end mark


//下载点赞列表数据
-(void)loadLikeListData:(int)page
{
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_LIKELIST];
    
    [LoadModel postRequestWithUrl:strURL andParams:PARAM_TWEET_LIKELIST(self.tweetLikeID, page, 100) andSucBlock:^(id responseObject) {
       
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement * result = obj.rootElement;

        NSArray * arrTweetLikeList = [[result firstChildWithTag:@"likeList"]childrenWithTag:@"user"];
        
        //判断
        if (self.page ==0)
        {
            //移除数组内所有内容
            [self.arrData removeAllObjects];
        }
        
        for (ONOXMLElement * objXml in arrTweetLikeList)
        {
            TweetLikeListXmlModel * tweetLikeListModel = [TweetLikeListXmlModel tweetLikeListXmlModelWithXml:objXml];
            [self.arrData addObject:tweetLikeListModel];
        }
        
        
        if (self.arrData.count<=(page+1)*100) {
            //无更多数据
            [self.tableView.footer setState:MJRefreshFooterStateNoMoreData];
        }
        
        //刷新表格
        [self.tableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}


//下拉与上提
-(void)addRefreshAction
{
    __weak typeof(self)weakSelf = self;
    
    //下拉
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakSelf.arrData removeAllObjects];
//        [weakSelf.tableView.footer setState:MJRefreshFooterStateRefreshing];
        weakSelf.page = 0;
        [weakSelf loadLikeListData:weakSelf.page];
        [weakSelf.tableView.header endRefreshing];
    }];
    
    //上提
    [self.tableView addLegendFooterWithRefreshingBlock:^{

        weakSelf.page++;
        [weakSelf loadLikeListData:weakSelf.page];
        [weakSelf.tableView.footer endRefreshing];
        
    }];
}







#pragma mark - action

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
