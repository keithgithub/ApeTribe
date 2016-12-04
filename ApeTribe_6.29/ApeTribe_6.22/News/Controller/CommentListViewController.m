//
//  CommentListViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "CommentListViewController.h"
#import "HelpClass.h"
#import "LoadModel.h"
#import "URL.h"
#import "CommentXmlModel.h"
#import "CommentTableView.h"
#import "MJRefresh.h"
#import "CommentView.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface CommentListViewController ()<CommentTableViewDelegate,CommentViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *mArrCommentList;
@property (nonatomic,strong) CommentView *commentView;
@property (nonatomic,strong) CommentTableView *commentTableView;
@end

@implementation CommentListViewController

//发表评论
-(void)postCommentPub
{
    if ([self.commentView.textFieldComment.text isEqualToString:@""])
    {
        [HelpClass warning:@"请输入评论内容" andView:self.view andHideTime:1];
        return;
    }
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_COMMENT_PUB];
    
    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_COMMENT_PUB(self.catalog, self.Id, USER_MODEL.userId, self.commentView.textFieldComment.text, 1) andSucBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        //类型转换
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;//根元素
        ONOXMLElement *result1 = [result firstChildWithTag:@"result"];

        //错误编号
        NSInteger errorCode = [[[result1 firstChildWithTag:@"errorCode"] numberValue] integerValue];
        //错误信息
        NSString *errorMessage = [[result1 firstChildWithTag:@"errorMessage"] stringValue];
        if (errorCode == 1)
        {
            [HelpClass warning:errorMessage andView:self.view andHideTime:1];
            [self loadCommentListData:self.Id andCatalog:self.catalog andPage:0];
            
        }
        else
        {
            [HelpClass warning:errorMessage andView:self.view andHideTime:1];
        }
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

//输入框代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.commentView.textFieldComment resignFirstResponder];
    
    //上传评论
    [self postCommentPub];
    
    
    return YES;
}
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.commentView.frame = CGRectMake(0, SCREEN_SIZE.height-45-kbSize.height, SCREEN_SIZE.width, 45);
    [self.view addSubview:self.commentView];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.commentView.frame = CGRectMake(0, SCREEN_SIZE.height-45, SCREEN_SIZE.width, 45);
    [self.view addSubview:self.commentView];
}

//代理方法
-(void)comeBackWithString:(NSString *)str
{
    self.commentView.textFieldComment.placeholder = [NSString stringWithFormat:@"回复%@:",str];
}
-(void)commentWithTag:(NSInteger)tag
{
    
}
-(void)loadCommentDataWithCurrentPage:(long)page
{
    [self loadCommentListData:self.Id andCatalog:self.catalog andPage:page];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    [self.view addSubview:self.commentView];
    [self loadCommentListData:self.Id andCatalog:self.catalog andPage:0];
}
-(void)loadCommentListData:(long)Id andCatalog:(long)catalog andPage:(long)page
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_COMMENT_LIST];
    
    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_COMMENT_LIST(self.catalog, self.Id, page, 20) andSucBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (page == 0)
        {
            [self.mArrCommentList removeAllObjects];
        }
        
        //类型转换
        ONOXMLDocument *obj = responseObject;
        
        ONOXMLElement *result = obj.rootElement;//根元素
    
        
            NSArray *arrData=[[result  firstChildWithTag:@"comments"] childrenWithTag:@"comment"];
            for (ONOXMLElement *objectXML in arrData)
            {
                CommentXmlModel *obj = [CommentXmlModel commmentXmlModelWithXml:objectXML];
                [self.mArrCommentList addObject:obj];
            }
            
            self.commentTableView.arrCommentDatas = self.mArrCommentList;
            [self.commentTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            
            [self.commentTableView.header endRefreshing];
            [self.commentTableView.footer endRefreshing];
        
    } andFailBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
-(CommentView*)commentView
{
    if (_commentView == nil)
    {

        _commentView = [[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:nil options:nil][1];
        _commentView.frame = CGRectMake(0, SCREEN_SIZE.height-45, SCREEN_SIZE.width, 45);
        _commentView.gDelegate = self;
        _commentView.textFieldComment.delegate = self;
    }
    return  _commentView;
}
//懒加载表格
-(CommentTableView*)commentTableView
{
    if (_commentTableView == nil)
    {
        _commentTableView = [[CommentTableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, SCREEN_SIZE.height-45-64) style:UITableViewStylePlain];
        
        _commentTableView.gDelegate = self;
        
        [self.view addSubview:_commentTableView];
    }
    return _commentTableView;
}
-(NSMutableArray*)mArrCommentList
{
    if (_mArrCommentList == nil)
    {
        _mArrCommentList = [NSMutableArray new];
    }
    return _mArrCommentList;
}

@end
