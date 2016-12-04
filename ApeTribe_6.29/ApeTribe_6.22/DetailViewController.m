//
//  DetailViewController.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "LoadModel.h"
#import "UIImageView+WebCache.h"
#import "DetailTableViewHeader.h"
#import "MTTableView.h"
#import "ZanViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MJRefresh.h"
#import "InteractivityTransitionDelegate.h"
#import "BaseTableViewCell.h"
#import "LoginViewController.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface DetailViewController ()

//协议
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, BaseTableViewCellDelegate>

//表格头视图
@property(nonatomic,strong)DetailTableViewHeader * detailTVH;

//漫谈列表数据
//@property(nonatomic,strong)TweetListXmlModel * tweetListmodel;

//漫谈详情数据
@property(nonatomic,strong)TweetDetailXmlModel * tweetDetailModel;
//评论数据
@property(nonatomic,strong)TweetCommentXmlModel * tweetCommentModel;

//漫谈列表ID
@property(nonatomic,assign)long tweetID;

//页码
@property(nonatomic,assign)int page;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    self.title = @"漫谈详情";
    //背景图片
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

        
    //添加视图单击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewAction:)];
    [self.view addGestureRecognizer:tap];
    
    //键盘通知（显示）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘通知（隐藏）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    //初始化评论数组
    self.arrCommentData = [NSMutableArray new];
    
    //创建表格
    [self createTableView];

    
    //初始化页码
    self.page = 0;
    
    //下载评论数据
    [self loadTweetCommentData:self.page];
    
    //下载漫谈详情数据
    [self loadTweetDetailData];
    
    
    //文本框及表情符号按钮
    [self createTxtFieldAndEmojiBtn];
    
    //下拉与上提刷新
    [self addRefreshAction];

}


//创建表格
-(void)createTableView
{
    //创建表格
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-104) style:UITableViewStylePlain];
    //代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //取消表格的线
    self.tableView.separatorStyle = NO;
    //背景颜色
    self.tableView.backgroundColor = [UIColor whiteColor];
    //隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    //显示
    [self.view addSubview:self.tableView];
    
    

}

//创建表格头部视图
-(void)createHeader
{
    //获取xib的第0个下标视图
    self.detailTVH = (DetailTableViewHeader *)[[NSBundle mainBundle]loadNibNamed:@"DetailTableViewHeader" owner:nil options:nil][0];
    //重新定义xib大小
    self.detailTVH.frame = CGRectMake(0, 0, SCREEN_W, 235);
    __weak typeof(self) weakself = self;
    self.detailTVH.portraitHandle = ^(long userId)
    {
        [weakself clickButtonAction:userId];
    };
    //设为表格头视图
    self.tableView.tableHeaderView = self.detailTVH;
    //设置表格头数据
    [self.detailTVH setHeader:self.tweetDetailModel];

   
    //点赞按钮
    __weak typeof(self)weakSelf = self;
    
    self.detailTVH.btnZanHandle = ^(int zan)
    {
        if (self.tweetDetailModel.isLike ==0)
        {
            if (USER_MODEL.userId ==0)
            {
                [MBProgressHUD showError:@"请先登录！"];
            }
            [weakSelf tweetLikeAction];
            weakSelf.detailTVH.btnLike = [UIButton buttonWithType:UIButtonTypeCustom];
            [weakSelf.detailTVH.btnLike setImage:[UIImage imageNamed:@"ic_thumbup_normal"] forState:UIControlStateNormal];
            [MBProgressHUD showSuccess:@"点赞成功！"];

        }
        else if(self.tweetDetailModel.isLike ==1)
        {
            if (USER_MODEL.userId ==0)
            {
                [MBProgressHUD showError:@"请先登录！"];
            }
            [weakSelf tweetUnLikeAction];
            weakSelf.detailTVH.btnLike = [UIButton buttonWithType:UIButtonTypeCustom];
            [weakSelf.detailTVH.btnLike setImage:[UIImage imageNamed:@"ic_thumbup_actived"] forState:UIControlStateNormal];
            [MBProgressHUD showSuccess:@"取消点赞成功！"];
        }
    };
}

//创建单元格
-(void)createCell
{
    //单元格Nib
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //设置单元格数据
//    [self.cell setCell:self.tweetCommentModel];
}



#pragma mark 表格代理


//单元格数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrCommentData.count;
}


//单元格样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.cell == nil)
    {
        self.cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //设置内容
    [self.cell setCell:self.arrCommentData[indexPath.row]];
    self.cell.delegate = self;
    return self.cell;
}


//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65+self.cell.commentH;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


//组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * v = [[UIView alloc]initWithFrame:self.view.bounds];
    if (section == 0)
    {
        UILabel * lblText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
        if (_arrCommentData.count == 0)
        {
            lblText.text = @"没有评论";
        }
        else
        {
            lblText.text = [NSString stringWithFormat:@"%lu条评论",(unsigned long)_arrCommentData.count];
        }
        
        lblText.textAlignment = NSTextAlignmentCenter;
        lblText.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [v addSubview:lblText];
    }
    return v;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetCommentXmlModel *model = self.arrCommentData[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc]initWithListID:model.tweetCommentID];
    detailVC.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
    [self presentViewController:[Tool getNavigationController:detailVC andtransitioningDelegate:detailVC.customTransitionDelegate andNavigationViewControllerType:NavigationControllerNormalType] animated:YES completion:nil];
}

#pragma end mark

#pragma mark - BaseTableViewCellDelegate
- (void) clickButtonAction:(long)userId
{
    if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"])
    {
        MineViewController * mineVC = [[MineViewController alloc]initWithState:NO andUserId:self.tweetDetailModel.authorID andOperationType:NavigationControllerOperationTypePop];
        
        mineVC.customTransitionDelegate = [Tool getInteractivityTransitionDelegateWithType:InteractivityTransitionDelegateTypeNormal];
        
        [self presentViewController:[Tool getNavigationController:mineVC andtransitioningDelegate:mineVC.customTransitionDelegate andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
    }
    else
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
    }
    
}

//创建底部文本框及表情符号按钮
-(void)createTxtFieldAndEmojiBtn
{
    //创建底部视图
    self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H-104, SCREEN_W, 40)];
    //背景颜色
    self.bgV.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    //创建文本框
    self.txtField = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, SCREEN_W-45, 30)];
    self.txtField.borderStyle = UITextBorderStyleRoundedRect;
    //提示
    self.txtField.placeholder = @"说点啥吧";
    //字体大小
    self.txtField.font = [UIFont systemFontOfSize:16];
    //代理
    self.txtField.delegate = self;
    self.txtField.returnKeyType = UIReturnKeySend;
    self.txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //创建表情符号按钮
    self.btnEmoji = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnEmoji.frame = CGRectMake(10+self.txtField.frame.size.width, self.txtField.frame.origin.y, 30, 30);
    //设置图片
    [self.btnEmoji setImage:[UIImage imageNamed:@"send.jpg"] forState:UIControlStateNormal];
    //按钮响应
    [self.btnEmoji addTarget:self action:@selector(EmojiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //显示
    [self.view addSubview:self.bgV];
    [self.bgV addSubview:self.txtField];
    [self.bgV addSubview:self.btnEmoji];
}

//按钮响应
-(void)EmojiBtnAction:(UIButton *)sender
{
    if (USER_MODEL.userId ==0)
    {
        [MBProgressHUD showError:@"请先登录！"];
    }
    else if([self.txtField.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入评论！"];
    }
    else
    {
        [MBProgressHUD showSuccess:@"评论成功！"];
    }
    //发表评论
    [self tweetCommentPub];
    //清空文本框内的内容
    self.txtField.text = @"";
    //文本框取消第一响应
    [self.txtField resignFirstResponder];
    //刷新表格
    [self.tableView reloadData];
}

#pragma textField 文本框代理

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //文本框设为第一响应者
    [self.txtField isFirstResponder];
    return YES;
}

//文本框发送按钮
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 判断是否登录
    if ([[Tool readLoginState:LOGIN_STATE]isEqualToString:@"1"])
    {
        //发送评论
        [self tweetCommentPub];
        
        //取消文本框第一响应
        [self.txtField resignFirstResponder];
    }
    else
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
    }
    
    return YES;
}

#pragma end textField

//视图出现
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.header beginRefreshing];
    [self loadTweetCommentData:0];
}

//视图消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
  
}

//键盘显示
-(void)keyboardWillShow:(NSNotification *)notification1
{
    self.bgV.hidden = NO;
    NSDictionary* info = [notification1 userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
//    NSLog(@"%lf,%lf",kbSize.width,kbSize.height);
    self.bgV.frame = CGRectMake(0, SCREEN_SIZE.height-104-kbSize.height, SCREEN_SIZE.width, 45);
}
//键盘隐藏
-(void)keyboardWillHide:(NSNotification *)notification2
{
    
    self.bgV.frame = CGRectMake(0, SCREEN_SIZE.height-104, SCREEN_SIZE.width, 45);
}



//下载漫谈详情数据
-(void)loadTweetDetailData
{
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_DETAIL];
    
    [LoadModel postRequestWithUrl:strURL andParams:PARAM_TWEET_DETAIL(self.tweetID) andSucBlock:^(id responseObject) {
    
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement * result = obj.rootElement;
        
        NSArray * arrTweetDetail = [result childrenWithTag:@"tweet"];
        
        for (ONOXMLElement * objXml in arrTweetDetail)
        {
            self.tweetDetailModel = [TweetDetailXmlModel tweetDetailXmlModelWithXml:objXml];
        }
        //头部视图
        [self createHeader];
        //高度
        self.detailTVH.frame = CGRectMake(0, 0, SCREEN_W, self.detailTVH.tempH+65);
        self.tableView.tableHeaderView = self.detailTVH;
        
        //刷新表格
        [self.tableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

//下载漫谈评论列表
-(void)loadTweetCommentData:(int)page
{
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_COMMENT];
    
    [LoadModel postRequestWithUrl:strURL andParams:PARAM_TWEET_COMMENT(3, self.tweetID, page, 20) andSucBlock:^(id responseObject) {
        
        
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement * result = obj.rootElement;
       
        NSArray * arrTweetComment = [[result firstChildWithTag:@"comments"]childrenWithTag:@"comment"];
        
        if (page ==0)
        {
            [self.arrCommentData removeAllObjects];
        }
        
        for (ONOXMLElement * objXml in arrTweetComment)
        {
            self.tweetCommentModel = [TweetCommentXmlModel tweetCommentXmlModelWithXml:objXml];
            [self.arrCommentData addObject:self.tweetCommentModel];
        }
        
        //单元格
        [self createCell];
        
        if (self.arrCommentData.count<(page+1)*20)
        {
            //无更多数据
            [self.tableView.footer setState:MJRefreshFooterStateNoMoreData];
        }

        
        //刷新表格
        [self.tableView reloadData];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}


//发表评论
-(void)tweetCommentPub
{
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_COMMENT_PUB];
    
    [LoadModel postRequestWithUrl:strURL andParams:PARAM_COMMENT_PUB(3, self.tweetDetailModel.tweetDetailID, USER_MODEL.userId, self.txtField.text, 0) andSucBlock:^(id responseObject) {
       
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement *result = obj.rootElement;
        NSLog(@"rootElement ==%@",obj.rootElement);
        //错误编号
        NSInteger errorCode = [[[result firstChildWithTag:@"errorCode"]numberValue]integerValue];
        //错误信息
        NSString *errorMessage = [[result firstChildWithTag:@"errormessage"]stringValue];
        
        if (errorCode == 1)
        {
            NSString *err = [NSString stringWithFormat:@"%@", errorMessage];
            [MBProgressHUD showError:err];
        }
     

    } andFailBlock:^(NSError *error) {
        
        NSString * err = [NSString stringWithFormat:@"%@",error];
        [MBProgressHUD showError:err];
        
    }];
}


//点赞方法
-(void)tweetLikeAction
{
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_LIKE];
    
    [LoadModel postRequestWithUrl:strURL andParams:PARAM_TWEET_LIKE(USER_MODEL.userId, self.tweetDetailModel.tweetDetailID, self.tweetDetailModel.authorID) andSucBlock:^(id responseObject) {
       
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement *result = obj.rootElement;
        
        //错误编号
        NSInteger errorCode = [[[result firstChildWithTag:@"errorCode"]numberValue]integerValue];
        //错误信息
        NSString *errorMessage = [[result firstChildWithTag:@"errormessage"]stringValue];
        
        if (errorCode == 1)
        {
            NSString *err = [NSString stringWithFormat:@"%@", errorMessage];
            [MBProgressHUD showError:err];
        }
//        else
//        {
//            [MBProgressHUD showSuccess:@"点赞成功！"];
//        }

    } andFailBlock:^(NSError *error) {
        
        NSString * err = [NSString stringWithFormat:@"%@",error];
        [MBProgressHUD showError:err];
        
    }];
}


//取消点赞方法
-(void)tweetUnLikeAction
{
    NSString * strURL = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_TWEET_UNLIKE];
    
    [LoadModel postRequestWithUrl:strURL andParams:PARAM_TWEET_UNLIKE(USER_MODEL.userId, self.tweetDetailModel.tweetDetailID, self.tweetDetailModel.authorID) andSucBlock:^(id responseObject) {
        
        //类型转换
        ONOXMLDocument *obj = responseObject;
        //根元素
        ONOXMLElement *result = obj.rootElement;
        
        //错误编号
        NSInteger errorCode = [[[result firstChildWithTag:@"errorCode"]numberValue]integerValue];
        //错误信息
        NSString *errorMessage = [[result firstChildWithTag:@"errormessage"]stringValue];
        
        if (errorCode == 1)
        {
            NSString *err = [NSString stringWithFormat:@"%@", errorMessage];
            [MBProgressHUD showError:err];
        }
//        else
//        {
//            [MBProgressHUD showSuccess:@"取消点赞成功！"];
//        }

    } andFailBlock:^(NSError *error) {
        
    }];
}






//手势响应
-(void)tapViewAction:(UITapGestureRecognizer *)sender
{
    [self.txtField resignFirstResponder];
}


//重写方法
-(instancetype)initWithListID:(long)ID
{
    if (self = [super init])
    {
        self.tweetID = ID;
    }
    return self;
}



//点击标签响应
-(void)tapLikeListAction
{
    //点赞列表控制器
    ZanViewController * zanVC = [[ZanViewController alloc]init];
    //属性传值
    zanVC.tweetLikeID = self.tweetID;
    //push
    [self.navigationController pushViewController:zanVC animated:YES];
}




//评论头像响应
-(void)tapCommentAction
{
    MineViewController * commentVC = [[MineViewController alloc]initWithState:NO andUserId:self.tweetCommentModel.authorID andOperationType:NavigationControllerOperationTypePop];
    [self.navigationController pushViewController:commentVC animated:YES];
}



//下拉与上提
-(void)addRefreshAction
{
    __weak typeof(self)weakSelf = self;
    
    //下拉
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
       
        [weakSelf.tableView.footer setState:MJRefreshFooterStateRefreshing];
        weakSelf.page = 0;
        [weakSelf loadTweetCommentData:weakSelf.page];
        [weakSelf.tableView.header endRefreshing];
        
    }];
    
    //上提
    [self.tableView addLegendFooterWithRefreshingBlock:^{
       
        weakSelf.page++;
        [weakSelf loadTweetCommentData:weakSelf.page];
        [weakSelf.tableView.footer endRefreshing];
        
    }];
    
}




//-(instancetype)initWithState:(BOOL)isMe andUserId:(long)userId
//{
//    MineViewController  *vc = [[MineViewController alloc]initWithState:YES andUserId:USER_MODEL.userId];
//    [self.navigationController pushViewController:vc animated:YES];
//
//    return self;
//}







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
