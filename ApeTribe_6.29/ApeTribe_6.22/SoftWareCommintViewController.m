//
//  SoftWareCommintViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SoftWareCommintViewController.h"
#import "SoftWareTableViewCell.h"
#import "SoftWareXMLModel.h"
#import "LoadModel.h"
#import "Ono.h"
#import "NSString+LabelHight.h"
#import "MJRefresh.h"

#import "DetailViewController.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface SoftWareCommintViewController ()
/**数据数组*/
@property(nonatomic,strong)NSMutableArray*mArrData;
//当前下载页码
@property (nonatomic,assign) long currentPage;
//当前下载个数
@property (nonatomic,assign) long pagesize;
@end

@implementation SoftWareCommintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"软件动弹列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    NSDictionary *dic = @{@"project":@(self.softId),@"pageIndex":@(0),@"pageSize":@(20)};
    //下载数据
    [self loadMyData:dic];
    //注册
    UINib *nib = [UINib nibWithNibName:@"SoftWareTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"softcell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加下拉刷新
    __block SoftWareCommintViewController *gTableVC = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        
        NSDictionary *dic = @{@"project":@(gTableVC.softId),@"pageIndex":@(0),@"pageSize":@(20)};
        //下载数据
        [gTableVC loadMyData:dic];
    }];
    //初始化第一页
    gTableVC.currentPage = 0;
    
    //添加上提刷新
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        
        //判断是否有下一页
        if ( gTableVC.pagesize<20)
        {
            //最后一页
            //弹框背景
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            //设置消失时间
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            //设置信息内容
            [SVProgressHUD showInfoWithStatus:@"已经是最后一页！"];
            //结束刷新
            [gTableVC.tableView.footer endRefreshing];
            
        }else
        {
            
            gTableVC.currentPage++;
            NSDictionary *dic = @{@"project":@(gTableVC.softId),@"pageIndex":@( gTableVC.currentPage),@"pageSize":@(20)};
            //下载数据
            [gTableVC loadMyData:dic];
            
            
        }
        
    }];

    
    self.mArrData = [NSMutableArray new];
    
    
}
-(void)loadMyData:(NSDictionary *)param
{
   NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_SOFTWARE_TWEET_LIST];
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
        
        
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;
        ONOXMLElement *softObj = [result firstChildWithTag:@"tweets"];
        NSArray *arr = [softObj childrenWithTag:@"tweet"];
        //下载的个数
        self.pagesize = [[[result firstChildWithTag:@"pageSize"] numberValue]longValue];
        NSMutableArray *mArr = [NSMutableArray new];
        for (ONOXMLElement * object in arr)
        {
            SoftWareXMLModel * swXMLModel = [[SoftWareXMLModel alloc]initWithXML:object];
            [mArr addObject:swXMLModel];
        }
        
        if (self.currentPage>=1)//加载下一页
        {
            [self.mArrData addObjectsFromArray:mArr];
            
        }else
        {
            self.mArrData = mArr;
            
        }
        //刷新表格
        [self.tableView reloadData];
        //结束下拉刷新
        [self.tableView.header endRefreshing];
        //结束上提刷新
        [self.tableView.footer endRefreshing];
        
    } andFailBlock:^(NSError *error) {
        
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return self.mArrData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SoftWareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"softcell" forIndexPath:indexPath];
    SoftWareXMLModel *model = self.mArrData[indexPath.row];
    
    [cell setCellModel:model];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取真实高度
    SoftWareXMLModel *model1 = self.mArrData[indexPath.row];
    
    CGFloat heigh = [NSString calStrSize:model1.body andWidth:SCREEN_SIZE.width-96 andFontSize:14].height;
    return 94+heigh-21;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //获取数据
    SoftWareXMLModel *model1 = self.mArrData[indexPath.row];
    //跳转到动弹详情
    DetailViewController *detailVC = [[DetailViewController alloc]initWithListID:model1.softid];
    detailVC.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];

    [self presentViewController:[Tool getNavigationController:detailVC andtransitioningDelegate:detailVC.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
    
    
}



@end
