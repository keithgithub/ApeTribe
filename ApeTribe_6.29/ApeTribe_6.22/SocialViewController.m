//
//  SocialViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SocialViewController.h"
#import "SearchTableViewCell.h"
#import "SearchXMLModel.h"
#import "DetailDiscoverController.h"
#import "PostDetailViewController.h"
#import "MJRefresh.h"
@interface SocialViewController ()

@end

@implementation SocialViewController
static NSString *ID = @"social";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"SearchTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"searchcell"];
    self.mArrData  =[NSMutableArray new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //添加下拉刷新
    __block SocialViewController *gTableView = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
       
        //上传数据，判断是否登录
        if (![[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [gTableView.navigationController presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
            [gTableView.tableView.header endRefreshing];
        }else
        {
            //下载第一页
            [gTableView.adelegate SocialViewController:gTableView andInteger:1];
            
        }
        
        
    }];
    //初始化第一页
    gTableView.currentPage = 1;
    //添加上提刷新
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        
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
            [gTableView.tableView.footer endRefreshing];
            
        }else
        {
            
            gTableView.currentPage++;
            //有下一页
            [gTableView.adelegate SocialViewController:gTableView andInteger:gTableView.currentPage];
            
            
        }
        
    }];

    
    
    
    
    
    
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mArrData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchcell" forIndexPath:indexPath];
    SearchXMLModel *model = self.mArrData[indexPath.row];
    [cell setCell:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchXMLModel *model = self.mArrData[indexPath.row];
    YDViewController *vc;
    if ([model.type isEqualToString:@"project"])
    {
        DetailDiscoverController *detailVC = [[DetailDiscoverController alloc]init];
        detailVC.url = model.url;
        vc = detailVC;
    }
    else
    {
        UIStoryboard *std = [UIStoryboard storyboardWithName:@"AnswerStoryBoard" bundle:[NSBundle mainBundle]];
        PostDetailViewController *postVC = [std instantiateViewControllerWithIdentifier:@"PostDetailVC"];
        vc = postVC;	
        if ([model.type isEqualToString:@"post"])
        {
            
            
            postVC.type = 3;
            postVC.Id = model.softid;
            
            
        }else if ([model.type isEqualToString:@"blog"])
        {
            
            postVC.type = 1;
            postVC.Id = model.softid;
            
        }else
        {
            
            postVC.type = 0;
            postVC.Id = model.softid;
            
        }

    }
    vc.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
    
    [self presentViewController:[Tool getNavigationController:vc andtransitioningDelegate:vc.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
    
    
    
}

@end
