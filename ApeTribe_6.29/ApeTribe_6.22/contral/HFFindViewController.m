//
//  HFFindViewController.m
//  6.23新项目
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 huangfu. All rights reserved.
//

#import "HFFindViewController.h"
#import "SearchResultTableView.h"
#import "Ono.h"
#import "LoadModel.h"
#import "SVProgressHUD.h"
#import "URL.h"
#import "FindXMLModel.h"
#import "MineViewController.h"
@interface HFFindViewController ()<UISearchBarDelegate>
/**导航栏右侧按钮*/
@property(nonatomic,strong)UIButton*btn;
@property(nonatomic,strong)SearchResultTableView *searchResurtTableView;//搜索表格对象
@property(nonatomic,strong)NSMutableArray *mData;
@end
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@implementation HFFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建搜索栏
    UISearchBar *searBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    searBar.placeholder = @"输入用户昵称";
    self.navigationItem.titleView = searBar;
    searBar.delegate = self;
    //创建左侧按钮
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftbtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    //创建导航栏右侧按钮
    //    [self configNav];
    
    //初始化搜索框表格
    self.searchResurtTableView = [[SearchResultTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, self.view.frame.size.height+64) style:UITableViewStylePlain andSelectBlock:^(FindXMLModel *findModel) {
        //跳转到用户个人中心
        MineViewController *mineVC = [[MineViewController alloc]initWithState:NO andUserId:findModel.userid andOperationType:NavigationControllerOperationTypePop];
        [self.navigationController pushViewController:mineVC animated:YES];
        
        
        
    }];
    
    [self.view addSubview:self.searchResurtTableView];
    
}

-(void)loadMyDataDic:(NSDictionary*)param
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_FINF_USER];
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
        //类型转换
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;//根元素
        ONOXMLElement *users = [result firstChildWithTag:@"users"];
        NSArray *arrData = [users childrenWithTag:@"user"];
        //==============初始化数组=========================
        self.mData = [NSMutableArray new];
        for (ONOXMLElement *objectXML in arrData)
        {
            FindXMLModel *obj = [[FindXMLModel alloc]initWithXML:objectXML];
            [self.mData addObject:obj];
        }
        
        self.searchResurtTableView.arrData = self.mData;
        [self.searchResurtTableView reloadData];
        
        
    } andFailBlock:^(NSError *error) {
        
    }];
    
}


//导航栏取消按钮
-(void)leftbtn
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark
#pragma mark 搜索框文本发生改变的代理方法
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length != 0)
    {
        //下载
        NSDictionary *dic = @{@"name":searchText};
        [self loadMyDataDic:dic];
        
    }
    
}
//点击搜索框弹出的键盘上有个search，点击相应的事件

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    
}

@end
