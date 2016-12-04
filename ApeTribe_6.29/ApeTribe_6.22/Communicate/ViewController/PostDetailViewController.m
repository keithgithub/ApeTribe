//
//  PostDetailViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "PostDetailViewController.h"
#import "TagsPostViewController.h"
#import "SignUpViewController.h"
#import "CommentListViewController.h"
#import "LoadModel.h"
#import "URL.h"
#import "HelpClass.h"
#import "ONOXMLDocument.h"
#import "PostDetailXmlModel.h"
#import "PostDetailHeaderView.h"
#import "BloggerHeaderView.h"
#import "EventHeaderView.h"
#import "NSString+FontSize.h"
#import "TagsTitleScrollView.h"
#import "MessageDetailModel.h"
#import "BloggerDetailXmlModel.h"
#import "EventDetailXmlModel.h"
#import "SignUpViewController.h"
#import "MenuTool.h"
#import "CommentView.h"
#import "SVProgressHUD.h"
//表情
#import "ExpressionView.h"
//友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface PostDetailViewController ()<UIWebViewDelegate,TagsTitleViewDelegate,EventHeaderViewDelegate,MenuToolDelegate,CommentViewDelegate,UITextFieldDelegate,UMSocialUIDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) PostDetailHeaderView *webViewHeader;
@property (nonatomic,strong) BloggerHeaderView *bloggerHeaderView;
@property (nonatomic,strong) PostDetailHeaderView *newsHeaderView;
@property (nonatomic,strong) EventHeaderView *eventHeaderView;
@property (nonatomic,strong) MenuTool *menuToolView;
@property (nonatomic,strong) CommentView *commentView;
@property (nonatomic,strong) PostDetailXmlModel *postDetailModel;
@property (nonatomic,strong) MessageDetailModel *messageDetailModel;
@property (nonatomic,strong) BloggerDetailXmlModel *bloggerDeTailModel;
@property (nonatomic,strong) EventDetailXmlModel *eventDetailModel;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) BOOL favoriteSelected;
@property (nonatomic,assign) long isFavorite;
@property (nonatomic,copy) NSString *shareStrUrl;
@property (nonatomic,copy) NSString *shareTitle;
//表情
@property(nonatomic,assign)BOOL isFace;
@property(nonatomic,strong) ExpressionView *expressV;
@end

@implementation PostDetailViewController

-(void)creatQQkeyBoard
{
    self.expressV = (ExpressionView *)[[NSBundle mainBundle]loadNibNamed:@"ExpressionView" owner:nil options:nil][0];
    self.expressV.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 120);
    __weak typeof(self) weakSelf = self;
    self.expressV.textCallBlock = ^(NSString *text)
    {
        
        weakSelf.commentView.textFieldComment.text = [NSString stringWithFormat:@"%@%@",weakSelf.commentView.textFieldComment.text,text];
        //        weakSelf.btnSend.userInteractionEnabled = YES;
        //        [weakSelf.btnSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [weakSelf text00];
        
        
    };
    //删除按钮
    [self.expressV.btnDelete addTarget:self action:@selector(btnseleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILongPressGestureRecognizer *longPG = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(Action:)];
    [self.expressV.btnDelete addGestureRecognizer:longPG];
    
    
}
-(void)Action:(UILongPressGestureRecognizer *)longPG
{
    
    self.commentView.textFieldComment.text =nil;
    
}

-(void)btnseleteAction:(UIButton *)sender
{
    
    
    if (self.commentView.textFieldComment.text.length>0)
    {
        self.commentView.textFieldComment.text = [self.commentView.textFieldComment.text substringToIndex:self.commentView.textFieldComment.text.length-1];
        //        self.tipLabel.text = [NSString stringWithFormat:@"%ld/%ld字",self.textView.text.length+1, (long)MAXVALUE];
        
    }else{
        
        if (self.commentView.textFieldComment.text.length==0) {
            
        }
        
    }
    
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
    self.commentView.hidden = NO;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.commentView.frame = CGRectMake(0, SCREEN_SIZE.height-64-45-kbSize.height, SCREEN_SIZE.width, 45);
}
- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.commentView.frame = CGRectMake(0, SCREEN_SIZE.height-64-45, SCREEN_SIZE.width, 45);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    
    //从导航栏下面开始计算
    if ([self.navigationController respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    switch (self.type)
    {
        case 0:
            self.title = @"资讯详情";
            break;
        case 1:
            self.title = @"博文内容";
            break;
        case 2:
            self.title = @"活动详情";
            break;
        case 3:
            self.title = @"帖子详情";
            break;
            
        default:
            break;
    }
    
    [self creatQQkeyBoard];
    [self.view addSubview:self.webView];
    [self loadPostDetailWithUid:self.Id];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
}
-(void)sendMessageWithTag:(NSString*)tag
{
    TagsPostViewController *tagsPostVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TagsPostVC"];
    tagsPostVC.tag = tag;
    [self.navigationController pushViewController:tagsPostVC animated:YES];
}
-(void)gotoSignUpVC:(EventDetailXmlModel *)eventDetailModel
{
    //进入活动报名页
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Synthesize" bundle:nil];
    SignUpViewController *signUpVC = [storyBoard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    signUpVC.eventDetailModel = self.eventDetailModel;
    [self.navigationController pushViewController:signUpVC animated:YES];
}
//代理方法
-(void)doSomethingWithTag:(NSInteger)tag
{
    switch (tag)
    {
        case 0:
            self.commentView.hidden = NO;
            break;
        case 1:
        {
            
            
            switch (self.type)
            {
                case 0:
                {
                    CommentListViewController *commentListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentListVC"];
                    commentListVC.Id = self.messageDetailModel.newsId;
                    commentListVC.catalog = 1;
                    [self.navigationController pushViewController:commentListVC animated:YES];
                    break;
                }
//                case 1:
//                {
//                    CommentListViewController *commentListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentListVC"];
//                    commentListVC.Id = self.messageDetailModel.newsId;
//                    commentListVC.catalog = self.type+1;
//                    [self.navigationController pushViewController:commentListVC animated:YES];
//                    break;
//                }
                case 2:
                {
                    CommentListViewController *commentListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentListVC"];
                    commentListVC.Id = self.eventDetailModel.eventId;
                    commentListVC.catalog = 4;
                    [self.navigationController pushViewController:commentListVC animated:YES];
                    break;
                }
                case 3:
                {
                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Synthesize" bundle:[NSBundle mainBundle]];
                    CommentListViewController *commentListVC = [storyBoard instantiateViewControllerWithIdentifier:@"CommentListVC"];
                    commentListVC.Id = self.postDetailModel.postId;
                    commentListVC.catalog = 2;
                    [self.navigationController pushViewController:commentListVC animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            [self.commentView.textFieldComment becomeFirstResponder];
            break;
        }
        case 3:
        {
            self.favoriteSelected = !self.favoriteSelected;
            //添加收藏
            if (self.favoriteSelected == YES)
            {
                [self postFavoriteWithtype:self.favoriteType objId:self.Id index:0];
            }
            else
            {
                [self postFavoriteWithtype:self.favoriteType objId:self.Id index:1];
            }
            break;
        }
        case 4:
        {
          
                [UMSocialWechatHandler setWXAppId:@"wx6f2c2f302768cf07" appSecret:@"309d97f1e1da94fdb3427fad32fc2b5d" url:self.shareStrUrl];
                //微信、微信朋友圈
                [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.shareTitle;
                [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareStrUrl;
                //QQ、QQ空间
                [UMSocialData defaultData].extConfig.qqData.url = self.shareStrUrl;
                [UMSocialData defaultData].extConfig.qzoneData.url = self.shareStrUrl;
                
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:@"5774e4aee0f55a0ae6001483"
                                                  shareText:self.shareStrUrl
                                                 shareImage:[UIImage imageNamed:@"10"]
                                            shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms]
                                                   delegate:self];
                
            
            break;
        }
        case 5:
            
            break;
        default:
            break;
    }
}
-(void)commentWithTag:(NSInteger)tag
{
    switch (tag)
    {
        case 0:
        {
            [self.commentView.textFieldComment resignFirstResponder];
            self.commentView.hidden = YES;
            break;
        }
        case 1:
        {
            
            //表情按钮处添加下面代码  自定义表情
            
            //改变键盘状态
            [self.commentView.textFieldComment becomeFirstResponder];
            self.isFace = !self.isFace;
            if (self.isFace) {
                
                self.commentView.textFieldComment.inputView = self.expressV;
                
            }else
            {
                self.commentView.textFieldComment.inputView = nil;
            }
            
            [self.commentView.textFieldComment reloadInputViews];
            
            
            break;
        }
        case 2:
        {
            self.favoriteSelected = !self.favoriteSelected;
            //添加收藏
            if (self.favoriteSelected == YES)
            {
                [self postFavoriteWithtype:self.favoriteType objId:self.Id index:0];
            }
            else
            {
                [self postFavoriteWithtype:self.favoriteType objId:self.Id index:1];
            }
            
            break;
        }
        case 3:
        {
            [self.commentView.textFieldComment resignFirstResponder];
            
            //上传评论
            [self postCommentPub];
            
            break;
        }
        default:
            break;
    }
}
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
        }
        else
        {
            [HelpClass warning:errorMessage andView:self.view andHideTime:1];
        }

    } andFailBlock:^(NSError *error) {
        
    }];
}
//上传收藏
-(void)postFavoriteWithtype:(long)type objId:(long)objID index:(long)index//0添加收藏1删除收藏
{
    NSString *strUrl = [NSString new];
    if (index == 0)
    {
        strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_ADD_FAVORITE];
    }
    else
    {
        strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_DELETE_FAVORITE];
    }
    [LoadModel postRequestWithUrl:strUrl andParams:PARAM_FAVORITE(USER_MODEL.userId, objID, type) andSucBlock:^(id responseObject) {
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
            if (self.type != 1)
            {
                if (index == 1)
                {
                    [self.menuToolView.btnFavorite setBackgroundImage:[UIImage imageNamed:@"toolbar-star@2x"] forState:UIControlStateNormal];
                }
                else
                {
                    [self.menuToolView.btnFavorite setBackgroundImage:[UIImage imageNamed:@"toolbar-starred@2x"] forState:UIControlStateNormal];
                }
            }
           else
           {
               if (index == 1)
               {
                   [self.commentView.btnFavotite setBackgroundImage:[UIImage imageNamed:@"toolbar-star@2x"] forState:UIControlStateNormal];
               }
               else
               {
                   [self.commentView.btnFavotite setBackgroundImage:[UIImage imageNamed:@"toolbar-starred@2x"] forState:UIControlStateNormal];
               }
           }
            [HelpClass warning:errorMessage andView:self.view andHideTime:1];
        }
        else
        {
            self.favoriteSelected = NO;
            [HelpClass warning:errorMessage andView:self.view andHideTime:1];
        }
        

    } andFailBlock:^(NSError *error) {
        [HelpClass warning:@"网络加载失败" andView:self.view andHideTime:1];
    }];
}

-(void)loadPostDetailWithUid:(long)Id
{
    NSString *strUrl = [NSString new];
    //    NSDictionary *paramDict = [NSDictionary new];
    if (self.type == 3)
    {
        strUrl = [NSString stringWithFormat:@"%@%@?id=%ld",URL_HTTP_PREFIX,URL_POST_DETAIL,Id];
    }
    else if(self.type == 2)
    {
        strUrl = [NSString stringWithFormat:@"%@%@?id=%ld",URL_HTTP_PREFIX,URL_EVENT_DETAIL_LIST,Id];
    }
    else if(self.type == 1)
    {
        strUrl = [NSString stringWithFormat:@"%@%@?id=%ld",URL_HTTP_PREFIX,URL_BLOGGER_DETAIL_LIST,Id];
    }
    else
    {
        strUrl = [NSString stringWithFormat:@"%@%@?id=%ld",URL_HTTP_PREFIX,URL_NEW_DETAIL_LIST,Id];
    }
    
    [LoadModel postRequestWithUrl:strUrl andParams:nil andSucBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
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
            //            self.webView.scalesPageToFit = YES;
            NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>",(SCREEN_SIZE.width*0.75)];
            
            if (self.type == 3)
            {
                ONOXMLElement *post=[result  firstChildWithTag:@"post"];
                self.postDetailModel = [PostDetailXmlModel postXmlModelWithXml:post];
                [self.webView loadHTMLString:[str stringByAppendingString:self.postDetailModel.body]  baseURL:nil];
                self.isFavorite = self.postDetailModel.favorite;
                self.catalog = 2;
                self.shareStrUrl = self.postDetailModel.url;
                self.shareTitle = self.postDetailModel.title;
            }
            else if (self.type == 2)
            {
                ONOXMLElement *eventDetailXml=[result firstChildWithTag:@"post"];
                self.eventDetailModel = [EventDetailXmlModel eventDetailXmlModelWithXml:eventDetailXml];
                [self.webView loadHTMLString:[str stringByAppendingString:self.eventDetailModel.body]  baseURL:nil];
                self.isFavorite = self.eventDetailModel.favorite;
                self.catalog = 1;
                self.shareStrUrl = self.eventDetailModel.url;
                self.shareTitle = self.eventDetailModel.title;
            }
            else if (self.type == 1)
            {
                ONOXMLElement *news=[result  firstChildWithTag:@"blog"];
                self.bloggerDeTailModel = [BloggerDetailXmlModel bloggerDetailXmlModelWithXml:news];
                [self.webView loadHTMLString:[str stringByAppendingString:self.bloggerDeTailModel.body]  baseURL:nil];
                self.isFavorite = self.bloggerDeTailModel.favorite;
                self.catalog = 1;
                self.shareStrUrl = self.bloggerDeTailModel.url;
                self.shareTitle = self.bloggerDeTailModel.title;
            }
            else
            {
                ONOXMLElement *news=[result  firstChildWithTag:@"news"];
                self.messageDetailModel = [MessageDetailModel messageDetailXmlModelWithXml:news];
                [self.webView loadHTMLString:[str stringByAppendingString:self.messageDetailModel.body]  baseURL:nil];
                self.isFavorite = self.messageDetailModel.favorite;
                self.catalog = 1;
                self.shareStrUrl = self.messageDetailModel.url;
                self.shareTitle = self.messageDetailModel.title;
            }
            
            
            
        }
        
    } andFailBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%f",webView.scrollView.contentSize.height);
    NSLog(@"%f",webView.scrollView.contentSize.width);
    //    //定义JS字符串
    //    NSString *script = [NSString stringWithFormat: @"var script = document.createElement('script');"
    //                        "script.type = 'text/javascript';"
    //                        "script.text = \"function ResizeImages() { "
    //                        "var myimg;"
    //                        "var maxwidth=%f;" //屏幕宽度
    //                        "for(i=0;i <document.images.length;i++){"
    //                        "myimg = document.images[i];"
    //                        "myimg.height = maxwidth / (myimg.width/myimg.height);"
    //                        "myimg.width = maxwidth;"
    //                        "}"
    //                        "}\";"
    //                        "document.getElementsByTagName('p')[0].appendChild(script);",SCREEN_SIZE.width];//调整屏幕大小
    //    //添加JS
    //    [webView stringByEvaluatingJavaScriptFromString:script];
    //    //添加调用JS执行的语句
    //    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    if (self.type == 3)
    {
        self.height  = [self.postDetailModel.title calTextAizeWithFontSize:17 andTextWidth:SCREEN_SIZE.width-16].height+90;
        self.webViewHeader.frame = CGRectMake(0, -self.height, SCREEN_SIZE.width, self.height);
        [self.webView.scrollView addSubview:self.webViewHeader];
        [self.webViewHeader setPostDetailContentView:self.postDetailModel];
        //判断模型里面的数组是否为空
        if (self.postDetailModel.tags.count>0)
        {
            
            TagsTitleScrollView *tagsView = [[TagsTitleScrollView alloc]initWithFrame:CGRectMake(90, self.webViewHeader.frame.size.height-32, SCREEN_SIZE.width-90, 20) andTitle:self.postDetailModel.tags];
            tagsView.gDelegate = self;
            [self.webViewHeader addSubview:tagsView];
        }
        webView.scrollView.contentInset = UIEdgeInsetsMake(self.height, 0, 0, 0);
        //        //滚动到最上面
        webView.scrollView.contentOffset = CGPointMake(0, -self.height);
        [self.menuToolView setCommentNumber:self.postDetailModel.answerCount];
    }
    if (self.type == 2)
    {
        self.height  = [self.eventDetailModel.title calTextAizeWithFontSize:14 andTextWidth:SCREEN_SIZE.width-16].height+150;
        self.eventHeaderView.frame = CGRectMake(0, -self.height, SCREEN_SIZE.width, self.height);
        [self.webView.scrollView addSubview:self.eventHeaderView];
        [self.eventHeaderView setEventDetailHeaderView:self.eventDetailModel andGotoVC:^(EventDetailXmlModel *eventDetailModel) {
            
            
        }];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(self.height, 0, 0, 0);
        //滚动到最上面
        webView.scrollView.contentOffset = CGPointMake(0, -self.height);
        [self.menuToolView setCommentNumber:self.eventDetailModel.answerCount];
    }
    if (self.type == 1)
    {
        self.height  = [self.bloggerDeTailModel.where calTextAizeWithFontSize:14 andTextWidth:SCREEN_SIZE.width-16].height+[self.bloggerDeTailModel.title calTextAizeWithFontSize:18 andTextWidth:SCREEN_SIZE.width-16].height+145;
        self.bloggerHeaderView.frame = CGRectMake(0, -self.height, SCREEN_SIZE.width, self.height);
        [self.webView.scrollView addSubview:self.bloggerHeaderView];
        [self.bloggerHeaderView setBlogerDetailContentView:self.bloggerDeTailModel];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(self.height, 0, 0, 0);
        //滚动到最上面
        webView.scrollView.contentOffset = CGPointMake(0, -self.height);
    }
    else if(self.type == 0)
    {
        self.height  = [self.messageDetailModel.title calTextAizeWithFontSize:17 andTextWidth:SCREEN_SIZE.width-16].height+60;
        self.newsHeaderView.frame = CGRectMake(0, -self.height, SCREEN_SIZE.width, self.height);
        [self.webView.scrollView addSubview:self.newsHeaderView];
        [self.newsHeaderView setMessageDetailContentView:self.messageDetailModel];
        webView.scrollView.contentInset = UIEdgeInsetsMake(self.height, 0, 0, 0);
        //滚动到最上面
        webView.scrollView.contentOffset = CGPointMake(0, -self.height);
        
        [self.menuToolView setCommentNumber:self.messageDetailModel.commentCount];

    }
    
    
    //显示菜单栏
    if (self.type == 1)
    {
        if (self.isFavorite == 1)
        {
            [self.commentView.btnFavotite setBackgroundImage:[UIImage imageNamed:@"toolbar-starred@2x"] forState:UIControlStateNormal];
            self.favoriteSelected = 1;
        }
        else
        {
            [self.commentView.btnFavotite setBackgroundImage:[UIImage imageNamed:@"toolbar-star@2x"] forState:UIControlStateNormal];
            self.favoriteSelected = 0;
        }
        [self.view addSubview:self.commentView];
    }
    else
    {
        if (self.isFavorite == 1)
        {
            [self.menuToolView.btnFavorite setBackgroundImage:[UIImage imageNamed:@"toolbar-starred@2x"] forState:UIControlStateNormal];
            self.favoriteSelected = 1;
        }
        else
        {
            [self.menuToolView.btnFavorite setBackgroundImage:[UIImage imageNamed:@"toolbar-star@2x"] forState:UIControlStateNormal];
            self.favoriteSelected = 0;
        }
        [self.view addSubview:self.menuToolView];
        [self.view addSubview:self.commentView];
    }
    
}


//懒加载webView
-(UIWebView*)webView
{
    if (_webView == nil)
    {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-64-45)];
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
//        _webView.scrollView.bounces = NO;
    }
    return _webView;
}

-(PostDetailHeaderView*)webViewHeader
{
    if (_webViewHeader == nil)
    {
        
        _webViewHeader = [[NSBundle mainBundle]loadNibNamed:@"PostDetailView" owner:nil options:nil][0];
    }
    return _webViewHeader;
}
-(PostDetailHeaderView*)newsHeaderView
{
    if (_newsHeaderView == nil)
    {
        
        _newsHeaderView = [[NSBundle mainBundle]loadNibNamed:@"PostDetailView" owner:nil options:nil][1];
    }
    return _newsHeaderView;
}

-(BloggerHeaderView*)bloggerHeaderView
{
    if (_bloggerHeaderView == nil)
    {
        _bloggerHeaderView = [[NSBundle mainBundle]loadNibNamed:@"BloggerHeaderView" owner:nil options:nil][0];
    }
    return _bloggerHeaderView;
}
-(EventHeaderView*)eventHeaderView
{
    if (_eventHeaderView == nil)
    {
        _eventHeaderView = [[NSBundle mainBundle]loadNibNamed:@"EventHeaderView" owner:nil options:nil][0];
        _eventHeaderView.gDelegate =self;
    }
    return _eventHeaderView;
}
-(MenuTool*)menuToolView
{
    if (_menuToolView == nil)
    {
        
        if (self.type == 3)
        {
            _menuToolView = [[NSBundle mainBundle] loadNibNamed:@"MenuTool" owner:nil options:nil][0];
            _menuToolView.frame = CGRectMake(0, SCREEN_SIZE.height-45-64, SCREEN_SIZE.width, 45);
            _menuToolView.gDelegate = self;
        }
        else if (self.type == 2 || self.type == 0)
        {
            _menuToolView = [[NSBundle mainBundle] loadNibNamed:@"MenuTool" owner:nil options:nil][1];
            _menuToolView.frame = CGRectMake(0, SCREEN_SIZE.height-45-64, SCREEN_SIZE.width, 45);
            _menuToolView.gDelegate = self;
        }
        
    }
    return  _menuToolView;
}
-(CommentView*)commentView
{
    if (_commentView == nil)
    {
        if (self.type == 1)
        {
            _commentView = [[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:nil options:nil][2];
            _commentView.frame = CGRectMake(0, SCREEN_SIZE.height-45-64, SCREEN_SIZE.width, 45);
            _commentView.gDelegate = self;
            _commentView.textFieldComment.delegate = self;
        }
        else
        {
            _commentView = [[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:nil options:nil][0];
            _commentView.frame = CGRectMake(0, SCREEN_SIZE.height-45-64, SCREEN_SIZE.width, 45);
            _commentView.gDelegate = self;
            _commentView.textFieldComment.delegate = self;
            _commentView.hidden = YES;
        }
        
    }
    return  _commentView;
}

@end
