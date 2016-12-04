//
//  SynthesizeViewController.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "SynthesizeViewController.h"
#import "PostDetailViewController.h"
#import "TitleScrollView.h"
#import "ImageScrollView.h"
#import "MessageTableView.h"
#import "BloggerTableView.h"
#import "EventTableView.h"
#import "SynthesizeView.h"
#import "AFHTTPRequestOperationManager+Util.h"
#import "Ono.h"
#import "LoadModel.h"
#import "HelpClass.h"
#import "URL.h"
#import "MessageXmlModel.h"
#import "BloggerXmlModel.h"
#import "EventXmlModel.h"
#import "MJRefresh.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface SynthesizeViewController ()<MessageTableViewDelegate,BloggerTableViewDelegate,EventTableViewDelegate,TitleScrollViewDelegate,SynthesizeViewDelegate,TitleScrollViewDelegate>

@property (nonatomic,strong) SynthesizeView *synthesizeView;//综合视图
@property (nonatomic,strong) NSMutableArray *mArrNewsDatas;//资讯数据
@property (nonatomic,strong) NSMutableArray *mArrImages;
@property (nonatomic,strong) NSMutableArray *mArrBloggerNewDatas;//博客最新数据
@property (nonatomic,strong) NSMutableArray *mArrBloggerHotDatas;//博客推荐数据
@property (nonatomic,strong) NSMutableArray *mArrEvenrDatas;//活动数据
@property (nonatomic,strong) NSMutableArray *mArrEvent;

@property (nonatomic,assign) long index;

@end

@implementation SynthesizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //设置导航栏名称
    self.mArrImages = [NSMutableArray new];
    self.title = @"综合";
    
    [self initSynthesizeView];
    [self loadMessageData:0];
    [self initScrollToTop];
        
}
-(void)gotoPostDetailVC:(long)Id andType:(long)type
{
    PostDetailViewController *postDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PostDetailVC"];
    postDetailVC.Id = Id;
    postDetailVC.type = type;
    postDetailVC.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
    if (type == 1)
    {
        postDetailVC.favoriteType = 3;
    }
    else
    {
        postDetailVC.favoriteType = 4;
    }
    [self presentViewController:[Tool getNavigationController:postDetailVC andtransitioningDelegate:postDetailVC.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
}

//初始化主界面
-(void)initSynthesizeView
{
    self.synthesizeView = [[SynthesizeView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, SCREEN_SIZE.height-64-44)];
    self.synthesizeView.messageTableView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    self.synthesizeView.bloggerTableView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    self.synthesizeView.eventTableView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    self.synthesizeView.gDelegate = self;
    self.synthesizeView.titleView.gDelegate = self;
    self.synthesizeView.messageTableView.gDelegate = self;
    self.synthesizeView.bloggerTableView.gDelegate = self;
    self.synthesizeView.eventTableView.gDelegate = self;
    [self.view addSubview:self.synthesizeView];
}
//实现代理方法
-(void)changgeContenOffSizeWithTag:(NSInteger)tag
{
    if (tag>13)
    {
        self.synthesizeView.scrollView.contentOffset = CGPointMake(3*SCREEN_SIZE.width, 0);
    }
    else
    {
        self.synthesizeView.scrollView.contentOffset = CGPointMake((tag - 11)*SCREEN_SIZE.width, 0);
    }
}
-(void)sendMessageWithTag:(long)tag
{
    self.index = tag;

    if (tag == 0)
    {
        [self loadMessageData:0];
    }
    else if (tag == 1)
    {
        [self loadBloggerData:0];
    }
    else
    {
        [self loadEventData:0];
    }
}
//实现活动代理方法
-(void)loadEventDataWithCurrentPage:(long)page
{
    [self loadEventData:page];
}
//实现博客代理方法
-(void)loadBloggerDataWithCurrentPage:(long)page
{
    [self loadBloggerData:page];
}

//实现代理方法
-(void)loadNewsDataWithCurrentPage:(long)page
{
    
    [self loadMessageData:page];
}

//下载活动数据
-(void)loadEventData:(long)page
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_EVENT_LIST];
  
    [LoadModel getRequestWithUrl:strUrl andSucBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (page == 0)
        {
            [self.mArrEvenrDatas removeAllObjects];
            [self.mArrEvent removeAllObjects];
        }
        //类型转换
        ONOXMLDocument *obj = responseObject;
        
        ONOXMLElement *result = obj.rootElement;//根元素
        
        NSArray *arrData=[[result  firstChildWithTag:@"events"] childrenWithTag:@"event"];
        
        for (ONOXMLElement *objectXML in arrData)
        {
            EventXmlModel *model = [EventXmlModel eventXmlModelWithXml:objectXML];
            [self.mArrEvent addObject:model];
        }
  
        [self.synthesizeView setContentWithIndex:2];
        self.synthesizeView.eventTableView.arrEventDatas = self.mArrEvent;
        [self.synthesizeView.eventTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        [self.synthesizeView.eventTableView.header endRefreshing];
        [self.synthesizeView.eventTableView.footer endRefreshing];
    } andFailBlock:^(NSError *error) {
        NSLog(@"err:%@",error);
    }];
}
//下载博客数据
-(void)loadBloggerData:(long) page
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_BLOGGER_LIST];
    
    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_BLOGGER_LIST(@"", page, 20) andSucBlock:^(id responseObject) {
        if (page == 0)
        {
            [self.mArrBloggerNewDatas removeAllObjects];
            [self.mArrBloggerHotDatas removeAllObjects];
        }
        //类型转换
        ONOXMLDocument *obj = responseObject;
        
        ONOXMLElement *result = obj.rootElement;//根元素
        
        NSArray *arrData=[[result  firstChildWithTag:@"blogs"] childrenWithTag:@"blog"];
        
        for (ONOXMLElement *objectXML in arrData)
        {
            BloggerXmlModel *obj = [BloggerXmlModel bloggerXmlModelWithXml:objectXML];
            if (obj.documentType == 1)
            {
                [self.mArrBloggerNewDatas addObject:obj];
            }
            else
            {
                [self.mArrBloggerHotDatas addObject:obj];
            }
        }
        [self.synthesizeView setContentWithIndex:1];
        self.synthesizeView.bloggerTableView.arrBloggerHotDatas = self.mArrBloggerHotDatas;
        self.synthesizeView.bloggerTableView.arrBloggerNewDatas = self.mArrBloggerNewDatas;
        [self.synthesizeView.bloggerTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
        [self.synthesizeView.bloggerTableView.header endRefreshing];
        [self.synthesizeView.bloggerTableView.footer endRefreshing];

    } andFailBlock:^(NSError *error) {
        NSLog(@"err:%@",error);
    }];

}
//下载资讯数据
-(void)loadMessageData:(long) page
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_NEW_LIST];

    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_NEW_LIST(0, page, 20) andSucBlock:^(id responseObject) {
        if (page == 0)
        {
            [self.mArrNewsDatas removeAllObjects];
        }
        
        //类型转换
        ONOXMLDocument *obj = responseObject;
        
        ONOXMLElement *result = obj.rootElement;//根元素
        //错误编号
        NSInteger errorCode = [[[result firstChildWithTag:@"errorCode"] numberValue] integerValue];
        //错误信息
        NSString *errorMessage = [[result firstChildWithTag:@"errormessage"] stringValue];
        
        if (errorCode == 1)
        {
            NSString *err = [NSString stringWithFormat:@"%@", errorMessage];
            DDLog(@"err:%@",err);
        }
        else
        {
            NSArray *arrData=[[result  firstChildWithTag:@"newslist"] childrenWithTag:@"news"];
            for (ONOXMLElement *objectXML in arrData)
            {
                MessageXmlModel *obj = [MessageXmlModel messageXmlModelWithXml:objectXML];
                [self.mArrNewsDatas addObject:obj];
            }
            if (page == 1)
            {
                for (int i = 0; i<5; i++)
                {
                    [self.mArrImages addObject:self.mArrNewsDatas[i]];
                }
            }
            [self.synthesizeView setContentWithIndex:0];
            self.synthesizeView.messageTableView.arrNewsDatas = self.mArrNewsDatas;
            [self.synthesizeView.messageTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            
            [self.synthesizeView.messageTableView.header endRefreshing];
            [self.synthesizeView.messageTableView.footer endRefreshing];
        }

    } andFailBlock:^(NSError *error) {
        NSLog(@"err:%@",error);
    }];
}
//懒加载
-(NSMutableArray*)mArrNewsDatas
{
    if (_mArrNewsDatas == nil)
    {
        _mArrNewsDatas = [NSMutableArray new];
    }
    return _mArrNewsDatas;
}
//懒加载
-(NSMutableArray*)mArrBloggerNewDatas
{
    if (_mArrBloggerNewDatas == nil)
    {
        _mArrBloggerNewDatas = [NSMutableArray new];
    }
    return _mArrBloggerNewDatas;
}
//懒加载
-(NSMutableArray*)mArrBloggerHotDatas
{
    if (_mArrBloggerHotDatas == nil)
    {
        _mArrBloggerHotDatas = [NSMutableArray new];
    }
    return _mArrBloggerHotDatas;
}
//懒加载
-(NSMutableArray*)mArrEvenrDatas
{
    if (_mArrEvenrDatas == nil)
    {
        _mArrEvenrDatas = [NSMutableArray new];
    }
    return _mArrEvenrDatas;
}
//懒加载
-(NSMutableArray*)mArrEvent
{
    if (_mArrEvent == nil)
    {
        _mArrEvent = [NSMutableArray new];
    }
    return _mArrEvent;
}





-(void)initScrollToTop
{
    UIButton *btnTop = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width-50, SCREEN_SIZE.height-44-50-10, 40, 40)];
    btnTop.layer.cornerRadius = 20;
    btnTop.layer.masksToBounds = YES;
    [btnTop setBackgroundImage:[UIImage imageNamed:@"Top"] forState:UIControlStateNormal];
    btnTop.alpha = 0.8;
    [btnTop addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTop];
}

-(void)btnAction:(UIButton*)tap
{
    switch (self.index)
    {
        case 0:
            [self.synthesizeView.messageTableView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
            [self.synthesizeView.bloggerTableView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 2:
            [self.synthesizeView.eventTableView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
            
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning
{
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
