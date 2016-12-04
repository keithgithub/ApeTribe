//
//  FeelingViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FeelingViewController.h"
#import "ButtonScrollView.h"
#import "MTTableView.h"
#import "HomeScrollView.h"
#import "DetailViewController.h"
#import "ZanViewController.h"
#import "DetailTableViewCell.h"
#import "MineViewController.h"
#import "InteractivityTransitionDelegate.h"


#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface FeelingViewController ()

@property(nonatomic,strong)ButtonScrollView * btnScrollView;
@property(nonatomic,strong)HomeScrollView * homeScrollView;


@end

@implementation FeelingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    self.title = @"漫谈";
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //滑动条
    [self createButtonScrollView];
    //滚动视图
    [self createHomeScrollView];
}


//滑动条
-(void)createButtonScrollView
{
    __weak typeof(self)weakself = self;
    //滑动按钮
    self.btnScrollView = [[ButtonScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, 38) andCallBackBlock:^(int index)
    {
        weakself.homeScrollView.index = index;
        [weakself.homeScrollView refreshTableView:1];
        [weakself.homeScrollView setContentOffset:CGPointMake(index * SCREEN_SIZE.width, 0) animated:NO];
                          }];
    [self.view addSubview:self.btnScrollView];
}


//表格滚动视图
-(void)createHomeScrollView
{
    self.homeScrollView = [[HomeScrollView  alloc]initWithFrame:CGRectMake(0, 38 + 64, SCREEN_SIZE.width, SCREEN_SIZE.height- 38 - 64)];
    [self.homeScrollView setTableViewWithArray:nil];
    //代码块变量
    __block FeelingViewController *hVC= self;
    
    //滚动视图滚动的回调
    self.homeScrollView.handleBlock = ^(NSInteger  currentPage)
    {
        //按钮去设置状态
        [hVC.btnScrollView changeButtonState:currentPage];
    };
    [self.view addSubview:self.homeScrollView];
    
    
    __weak typeof(self)weakself = self;
    
    self.homeScrollView.callBackBlock = ^(long ID)
    {
        //详情页
        DetailViewController * detail = [[DetailViewController alloc]initWithListID:ID];
        detail.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
        [weakself presentViewController:[Tool getNavigationController:detail andtransitioningDelegate:detail.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
    };
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
