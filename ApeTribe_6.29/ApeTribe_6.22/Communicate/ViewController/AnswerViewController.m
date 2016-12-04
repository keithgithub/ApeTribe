//
//  AnswerViewController.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "AnswerViewController.h"
#import "PostDetailViewController.h"
#import "AnswerTableView.h"
#import "LoadModel.h"
#import "URL.h"
#import "ONOXMLDocument.h"
#import "AnswerXmlModel.h"
#import "MJRefresh.h"
#import "TitleScrollView.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface AnswerViewController ()<AnswerTableViewDelegate,TitleScrollViewDelegate>
@property (nonatomic,strong) AnswerTableView *answerTableView;
@property (nonatomic,strong) NSMutableArray *mArrAnswerDatas;
@property (nonatomic,assign) long catalog;
@property (nonatomic,strong) UIButton *btnCatalog;
@property (nonatomic,strong) TitleScrollView *catalogSelectView;
@property (nonatomic,assign) BOOL btnCatalogSelected;
@property (nonatomic,strong) UIButton *btnTop;

@end

@implementation AnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数组
    self.mArrAnswerDatas = [NSMutableArray new];
    [self loadAnswerDataWithIndex:1 andPage:0 andPageCount:20];
    self.catalog = 1;
}


//代理方法
-(void)loadAnswerDataWithCurrentPage:(long)page
{
    [self loadAnswerDataWithIndex:self.catalog andPage:page andPageCount:20];
}
-(void)didScroll:(CGFloat)y
{
    if (y>2600)
    {
        self.btnTop.hidden = NO;
    }
    else if(y == 0)
    {
        self.btnTop.hidden = YES;
//        [self.answerTableView.header beginRefreshing];
//        static  dispatch_once_t  token;
//        dispatch_once(&token, ^{
//            [self.answerTableView.header beginRefreshing];
//        });

    }
}
-(void)scrollToTop
{
    [self.answerTableView.header beginRefreshing];
}

-(void)gotoPostDetailVC:(long)Id
{
    PostDetailViewController *postDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PostDetailVC"];
    postDetailVC.Id = Id;
    postDetailVC.type = 3;
    postDetailVC.favoriteType = 2;
    
    postDetailVC.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
    [self presentViewController:[Tool getNavigationController:postDetailVC andtransitioningDelegate:postDetailVC.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
}
//分类按代理方法
-(void)sendMessageWithTag:(long)tag
{
    self.catalog =tag+1;
    [self loadAnswerDataWithIndex:self.catalog andPage:0 andPageCount:self.mArrAnswerDatas.count];
}
-(void)changgeContenOffSizeWithTag:(NSInteger)tag
{
    
}
//下载问答的数据
-(void)loadAnswerDataWithIndex:(long)index andPage:(long)page andPageCount:(long)pageCount
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_ANSWER_LIST];
  
    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_ANSWER_LIST(index, page, pageCount) andSucBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (page == 0)
        {
            [self.mArrAnswerDatas removeAllObjects];
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
            NSArray *arrData=[[result  firstChildWithTag:@"posts"] childrenWithTag:@"post"];
            for (ONOXMLElement *objectXML in arrData)
            {
                AnswerXmlModel *obj = [AnswerXmlModel answerXmlModelWithXml:objectXML];
                [self.mArrAnswerDatas addObject:obj];
            }
            
            self.answerTableView.arrAnswerNewDatas = self.mArrAnswerDatas;
            [self.answerTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            
            [self.answerTableView.header endRefreshing];
            [self.answerTableView.footer endRefreshing];
        }

    } andFailBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
  
}
-(void)btnCatalogAction:(UIButton*)sender
{
    self.btnCatalogSelected = !self.btnCatalogSelected;
    if (self.btnCatalogSelected)
    {
        [self.btnCatalog setTitle:@"分类" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = self.catalogSelectView.frame;
            rect = CGRectMake(66, SCREEN_SIZE.height-102, 0, 50);
            self.catalogSelectView.frame = rect;
        } completion:^(BOOL finished) {
            self.catalogSelectView.hidden = YES;
        }];
    }
    else
    {
        [self.btnCatalog setTitle:@"收起" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            self.catalogSelectView.hidden = NO;
            CGRect rect = self.catalogSelectView.frame;
            rect = CGRectMake(66, SCREEN_SIZE.height-102, SCREEN_SIZE.width-66-8, 50);
            self.catalogSelectView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}
//懒加载表格
-(AnswerTableView*)answerTableView
{
    if (_answerTableView == nil)
    {
        _answerTableView = [[AnswerTableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, SCREEN_SIZE.height-44-64) style:UITableViewStylePlain];
        
        _answerTableView.gDelegate = self;
        
        [self.view addSubview:_answerTableView];
        //加载按钮
        [self.view addSubview:self.btnCatalog];
        //显示分类标题
        [self.view addSubview:self.catalogSelectView];
        //显示顶部按钮
        [self initScrollToTop];

    }
    return _answerTableView;
}
//懒加载分类按钮
-(UIButton*)btnCatalog
{
    if (_btnCatalog == nil)
    {
        _btnCatalog = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnCatalog.layer.cornerRadius = 25;
        _btnCatalog.layer.masksToBounds = YES;
        _btnCatalog.frame = CGRectMake(8, SCREEN_SIZE.height-102, 50, 50);
        _btnCatalog.backgroundColor = [UIColor colorWithRed:0.098 green:0.665 blue:0.180 alpha:1.000];
        _btnCatalog.tintColor = [UIColor colorWithRed:0.996 green:0.995 blue:1.000 alpha:1.000];
        _btnCatalog.alpha = 0.8;
        [_btnCatalog setTitle:@"收起" forState:UIControlStateNormal];
        [_btnCatalog addTarget:self action:@selector(btnCatalogAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCatalog;
}
-(TitleScrollView*)catalogSelectView
{
    if (_catalogSelectView == nil)
    {
        _catalogSelectView = [[TitleScrollView alloc]initWithFrame:CGRectMake(66, SCREEN_SIZE.height-102, SCREEN_SIZE.width-66-8, 50) andTitle:@[@"提问",@"分享",@"综合",@"职业",@"站务"]];
        _catalogSelectView.layer.borderWidth = 0.5;
        _catalogSelectView.layer.borderColor = [UIColor grayColor].CGColor;
        _catalogSelectView.gDelegate = self;
        _catalogSelectView.layer.cornerRadius =10;
        _catalogSelectView.layer.masksToBounds = YES;
        _catalogSelectView.alpha = 0.9;
    }
    return _catalogSelectView;
}

-(void)initScrollToTop
{
    UIButton *btnTop = [[UIButton alloc]initWithFrame:CGRectMake(13, SCREEN_SIZE.height-44-50-50, 40, 40)];
    btnTop.layer.cornerRadius = 20;
    btnTop.layer.masksToBounds = YES;
    [btnTop setBackgroundImage:[UIImage imageNamed:@"Top"] forState:UIControlStateNormal];
    btnTop.alpha = 0.8;
    [btnTop addTarget:self action:@selector(btnTopAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btnTop = btnTop;
    self.btnTop.hidden = YES;
    [self.view addSubview:self.btnTop];
}

-(void)btnTopAction:(UIButton*)sender
{
//    [self.answerTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    //创建一个最后一行的索引
    NSIndexPath *lastIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    //表格要滚动到最后一行
    // UITableViewScrollPositionBottom (底部位置)
    [self.answerTableView scrollToRowAtIndexPath:lastIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

@end
