//
//  TagsPostViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TagsPostViewController.h"
#import "PostDetailViewController.h"
#import "LoadModel.h"
#import "AnswerXmlModel.h"
#import "AnswerTableView.h"
#import "MJRefresh.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface TagsPostViewController ()<AnswerTableViewDelegate>

@property (nonatomic,strong) NSMutableArray *mArrTagsPostData;
@property (nonatomic,strong) AnswerTableView *answerTableView;
@property (nonatomic,strong) UIButton *btnTop;
@end

@implementation TagsPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数组
    self.mArrTagsPostData = [NSMutableArray new];
    self.title = self.tag;
    
    [self loadTagPostData:self.tag andPageIndex:0];
    [self initScrollToTop];
    
}
-(void)gotoPostDetailVC:(long)Id
{
    PostDetailViewController *postDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PostDetailVC"];
    postDetailVC.Id = Id;
    postDetailVC.type = 3;
    [self.navigationController pushViewController:postDetailVC animated:YES];
}
-(void)didScroll:(CGFloat)y
{
    
}
-(void)scrollToTop
{
    [self.answerTableView.header beginRefreshing];
}
//代理方法
-(void)loadAnswerDataWithCurrentPage:(long)page
{
    [self loadTagPostData:self.tag andPageIndex:page];
}
-(void)loadTagPostData:(NSString*)tag andPageIndex:(long)pageIndex
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_ANSWER_LIST];
    
    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_POST_TAG_LIST(tag, pageIndex, 20) andSucBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (pageIndex == 0)
        {
            [self.mArrTagsPostData removeAllObjects];
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
                [self.mArrTagsPostData addObject:obj];
            }
            
            self.answerTableView.arrAnswerNewDatas = self.mArrTagsPostData;
            [self.answerTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            
            [self.answerTableView.header endRefreshing];
            [self.answerTableView.footer endRefreshing];
        }
        
    } andFailBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}



//懒加载表格
-(AnswerTableView*)answerTableView
{
    if (_answerTableView == nil)
    {
        _answerTableView = [[AnswerTableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, SCREEN_SIZE.height-64) style:UITableViewStylePlain];
        
        _answerTableView.gDelegate = self;
        
        [self.view addSubview:_answerTableView];
        //显示顶部按钮
        [self initScrollToTop];
        
    }
    return _answerTableView;
}

-(void)initScrollToTop
{
    UIButton *btnTop = [[UIButton alloc]initWithFrame:CGRectMake(13, SCREEN_SIZE.height-44-50-50, 40, 40)];
    btnTop.layer.cornerRadius = 20;
    btnTop.layer.masksToBounds = YES;
    [btnTop setTitle:@"Top" forState:UIControlStateNormal];
    btnTop.backgroundColor = [UIColor blackColor];
    [btnTop setTitleColor:[UIColor colorWithRed:0.176 green:0.729 blue:0.412 alpha:1.000] forState:UIControlStateNormal];
    btnTop.alpha = 0.3;
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
