//
//  DiscoverScrollView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/25.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DiscoverScrollView.h"
#import "LoadModel.h"
#import "MJRefresh.h"
#import "Ono.h"
#import "URL.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation DiscoverScrollView
//实现协议方法page要下载的页数 
-(void)loadGoodsDataWithCurrentPage:(long)page andTableTag:(NSInteger)tableTag
{
   //改变参数判断是那个页面的参数
    switch (tableTag) {
        case 0:
        {
            NSDictionary *dic = @{@"searchTag":@"recommend",@"pageIndex":@(page),@"pageSize":@(20)};
          
            [self.paramArray replaceObjectAtIndex:tableTag withObject:dic];
            //调用下载方法
            [self loadTableDataWithIndex:tableTag andPage:page];
        }
            break;
        case 1:
        {
            NSDictionary *dic1 = @{@"searchTag":@"recommend",@"pageIndex":@(page),@"pageSize":@(20)};
            [self.paramArray replaceObjectAtIndex:tableTag withObject:dic1];
            //调用下载方法
            [self loadTableDataWithIndex:tableTag andPage:page];
        }
            break;
        case 2:
        {
            NSDictionary *dic2 = @{@"searchTag":@"time",@"pageIndex":@(page),@"pageSize":@(20)};
            [self.paramArray replaceObjectAtIndex:tableTag withObject:dic2];
            //调用下载方法
            [self loadTableDataWithIndex:tableTag andPage:page];


        }
            break;
        case 3:
        {
            NSDictionary *dic3 = @{@"searchTag":@"view",@"pageIndex":@(page),@"pageSize":@(20)};
            [self.paramArray replaceObjectAtIndex:tableTag withObject:dic3];
            //调用下载方法
            [self loadTableDataWithIndex:tableTag andPage:page];

        }
            break;
        case 4:
        {
            NSDictionary *dic4 = @{@"searchTag":@"list_cn",@"pageIndex":@(page),@"pageSize":@(20)};
            [self.paramArray replaceObjectAtIndex:tableTag withObject:dic4];
            //调用下载方法
            [self loadTableDataWithIndex:tableTag andPage:page];
        }
            break;
            
        default:
            break;
    }
    
}

-(instancetype)initWithFrame:(CGRect)frame andIndex:(NSInteger)index andTitleBlock:(SetTitleBlock)titleBlock andDisSelectTabCellBlock:(DisSelectTabCellBlock)selectTabCellBlock
{
    if (self = [super initWithFrame:frame])
    {
        
        self.oneArray = [NSMutableArray new];
        self.selectTabCellBlock = selectTabCellBlock;
        self.currentIndex = index;
        self.setTitleHandle = titleBlock;
        self.arrTableDatas = [NSMutableArray new];
        self.backgroundColor = [UIColor colorWithWhite:0.930 alpha:1.000];
        for (int i = 0; i < 5; i++)
        {
            NSMutableArray *arr = [NSMutableArray new];
            [self.arrTableDatas addObject:arr];
        }
        // 设置scrollView属性
        self.delegate = self;
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(SCREEN_SIZE.width * 5, 0);
        self.showsHorizontalScrollIndicator = NO;
        [self setContentOffset:CGPointMake(SCREEN_SIZE.width * index, 0)];
        
        //创建表格
        _classifyTV = [[DiscoverTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, frame.size.height) style:UITableViewStyleGrouped andcellStyle:DiscoverTableViewCellLeftStyle andTableViewCellBlock:^(SoftXMLModel *softXMLModel) {
             self.selectTabCellBlock(softXMLModel);
            
        }];
         //设置代理
        _classifyTV.loadDelegat =self;
      
        _recommendTV = [[DiscoverTableView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, frame.size.height) style:UITableViewStyleGrouped andcellStyle:DiscoverTableViewCellSubtitleStyle andTableViewCellBlock:^(SoftXMLModel *softXMLModel) {
            self.selectTabCellBlock(softXMLModel);
            
        }];
        //设置代理
        _recommendTV.loadDelegat =self;
          _recommendTV.tag =100;
        _newsTV = [[DiscoverTableView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width*2, 0, SCREEN_SIZE.width, frame.size.height) style:UITableViewStyleGrouped andcellStyle:DiscoverTableViewCellSubtitleStyle andTableViewCellBlock:^(SoftXMLModel *softXMLModel) {
            self.selectTabCellBlock(softXMLModel);
            
        }];
        //设置代理
        _newsTV.loadDelegat =self;
         _newsTV.tag =100;
        _hotTV = [[DiscoverTableView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width*3, 0, SCREEN_SIZE.width, frame.size.height) style:UITableViewStyleGrouped andcellStyle:DiscoverTableViewCellSubtitleStyle andTableViewCellBlock:^(SoftXMLModel *softXMLModel) {
            self.selectTabCellBlock(softXMLModel);
            
        }];
        //设置代理
        _hotTV.loadDelegat =self;
           _hotTV.tag =100;
        _chinaTV = [[DiscoverTableView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width*4, 0, SCREEN_SIZE.width, frame.size.height) style:UITableViewStyleGrouped andcellStyle:DiscoverTableViewCellSubtitleStyle andTableViewCellBlock:^(SoftXMLModel *softXMLModel) {
            self.selectTabCellBlock(softXMLModel);
            
        }];
        //设置代理
        _chinaTV.loadDelegat =self;
          _chinaTV.tag =100;
        [self addSubview:_classifyTV];
        [self addSubview:_recommendTV];
        [self addSubview:_newsTV];
        [self addSubview:_hotTV];
        [self addSubview:_chinaTV];
        //将表格添加到数组
        self.arrTableViews = @[_classifyTV,_recommendTV,_newsTV,_hotTV,_chinaTV];
        //设置内容区大小
        self.contentSize = CGSizeMake(SCREEN_SIZE.width*5, 0);
        //初始化参数数组
        [self getNetWorkParamArray];
        
    }
    return self;
}
#pragma end mark - UIScrollViewDelegate

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentIndex = scrollView.contentOffset.x / SCREEN_SIZE.width;
    // 设置标题
    self.setTitleHandle(self.currentIndex);
    [self loadTableDataWithIndex:self.currentIndex andPage:0];
    
}
// 单击按钮时设置显示的表格
- (void) setScrollContentOffset:(NSInteger)index
{
       self.currentIndex = index;
  
      [self loadTableDataWithIndex:index andPage:0];
    [self setContentOffset:CGPointMake(index * SCREEN_SIZE.width, 0) animated:NO];
    DiscoverTableView *tableV = self.arrTableViews[index];
    if (index !=0) {
        if (tableV.tag == 100)
        {
            //取出相应的表格
            [[self.arrTableViews[index] header] beginRefreshing];
             tableV.tag =101;
        }
       
        
    }
    
}


#pragma mark
#pragma mark 获取数据的参数列表
// 获取网络请求参数的数组
- (void)getNetWorkParamArray
{
    self.paramArray = [NSMutableArray new];
    NSDictionary *dic = @{@"searchTag":@"recommend",@"pageIndex":@(0),@"pageSize":@(20)};
    [self.paramArray addObject:dic];
    NSDictionary *dic1 = @{@"searchTag":@"recommend",@"pageIndex":@(0),@"pageSize":@(20)};
    [self.paramArray addObject:dic1];
    NSDictionary *dic2 = @{@"searchTag":@"time",@"pageIndex":@(0),@"pageSize":@(20)};
    [self.paramArray addObject:dic2];
    NSDictionary *dic3 = @{@"searchTag":@"view",@"pageIndex":@(0),@"pageSize":@(20)};
    [self.paramArray addObject:dic3];
    NSDictionary *dic4 = @{@"searchTag":@"list_cn",@"pageIndex":@(0),@"pageSize":@(20)};
    [self.paramArray addObject:dic4];

}


#pragma mark
#pragma mark 下载网络数据
- (void) loadTableDataWithIndex:(NSInteger)index andPage:(long)page
{
    
    if (index == 0)
    {
        return;
    }
    //取出下载的表格
     DiscoverTableView *tableView = self.arrTableViews[index];
     tableView.tableTag = index;
     NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_SOFTWARE_LIST];
    [LoadModel postRequestWithUrl:strUrl andParams:_paramArray[index] andSucBlock:^(id responseObject) {

        //类型转换
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;//根元素
        //下载的个数
        long pageSize = [[[result firstChildWithTag:@"pageSize"] numberValue]longValue];
        
        ONOXMLElement *softwares = [result firstChildWithTag:@"softwares"];
        NSArray *arrData = [softwares childrenWithTag:@"software"];

        //==============初始化数组=========================
        self.mData = [NSMutableArray new];
        for (ONOXMLElement *objectXML in arrData)
        {
            SoftXMLModel *obj = [[SoftXMLModel alloc]initWithXML:objectXML];
            [self.mData addObject:obj];
        }
  
        tableView.pagesize = pageSize;
        if (page>=1)//加载下一页
        {
            //累加商品
            [tableView.arrData addObjectsFromArray:self.mData];
            
        }else
        {
            //加载最新一页
            tableView.arrData = self.mData;
            
        }
        
        [self.arrTableDatas replaceObjectAtIndex:index withObject:self.mData];
        //刷新表格
        [tableView reloadData];
        //结束下拉刷新
        [tableView.header endRefreshing];
        //结束上提刷新
        [tableView.footer endRefreshing];
    } andFailBlock:^(NSError *error) {
       NSLog(@"err:%@",error); 
    }];
    
}

@end
