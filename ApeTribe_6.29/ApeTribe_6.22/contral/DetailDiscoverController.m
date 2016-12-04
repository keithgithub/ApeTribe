//
//  DetailDiscoverController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DetailDiscoverController.h"
#import "AFHTTPRequestOperationManager+Util.h"
#import "Ono.h"
#import "URL.h"
#import "LoadModel.h"
#import "SVProgressHUD.h"
#import "DetailScrollFootView.h"
#import "DetailSecondController.h"
#import "MenuTool.h"
#import "SoftWareCommintViewController.h"
#import "SoftWareXMLModel.h"
#import "ExpressionView.h"
//友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface DetailDiscoverController ()<UIWebViewDelegate,UIScrollViewDelegate,MenuToolDelegate,UITextFieldDelegate,UMSocialUIDelegate>
/**uiview*/
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)MenuTool *menuTool;
/**尾部视图*/
@property(nonatomic,strong)DetailScrollFootView*footView;
@property(nonatomic,strong)UITextField *textField;
/**uiview*/
@property(nonatomic,strong)UIView*buttomV;
/**计算个数*/
@property(nonatomic,strong)NSMutableArray*countMArr;
@property(nonatomic,assign)BOOL isFavorite;//是否收藏
@property(nonatomic,strong)ExpressionView*expressV;
@property(nonatomic,assign)BOOL isFace;
@end

@implementation DetailDiscoverController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"软件详情";
    self.view.backgroundColor = [UIColor whiteColor];
    //创建webview
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-44)];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    NSString *str;
    if (self.url)
    {
       str =[self.url substringFromIndex:25]; 
        
    }else
    {
        str =[self.softXMLModel.url substringFromIndex:25];
    }
   
    NSDictionary *dic = @{@"ident":str};
    [self loadMyDataDict:dic];
    [self.view addSubview:self.webView];
    
    [self registerForKeyboardNotifications];
    //初始化
    self.isFavorite = YES;
    
    [self creatQQkeyBoard];
    
}
//下载评论的个数
-(void)loadCount:(NSDictionary *)param
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_SOFTWARE_TWEET_LIST];
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
        
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;
        ONOXMLElement *softObj = [result firstChildWithTag:@"tweets"];
        NSArray *arr = [softObj childrenWithTag:@"tweet"];
        
        self.countMArr = [NSMutableArray new];
        for (ONOXMLElement * object in arr)
        {
            SoftWareXMLModel * swXMLModel = [[SoftWareXMLModel alloc]initWithXML:object];
            [self.countMArr addObject:swXMLModel];
        }
        if (self.countMArr.count ==0)
        {
            self.menuTool.commentCount.hidden =YES;
        }else
        {
            self.menuTool.commentCount.hidden =NO;
            self.menuTool.commentCount.text =[NSString stringWithFormat:@"%ld",self.countMArr.count];
            
        }
        [self.view addSubview:self.menuTool];
        //创建视图===========
        [self setButtom];
        
    } andFailBlock:^(NSError *error) {
        
    }];
    
}
-(void)setButtom
{
    UIView *buttomV = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_SIZE.height-45, SCREEN_SIZE.width, 45)];
    self.buttomV = buttomV;
    buttomV.backgroundColor = [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000];
    //=================================btn==============
    UIButton * btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleft.frame = CGRectMake(5, 7, 25,25);
    btnleft.tag = 0;
    [btnleft setBackgroundImage:[UIImage imageNamed:@"toolbar-text@2x"] forState:UIControlStateNormal];
    [btnleft addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttomV addSubview:btnleft];
    //========================textfield============================
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(35, 5 , SCREEN_SIZE.width-70, 30)];
    textField.backgroundColor = [UIColor whiteColor];
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(5, 5, 20,20);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"toolbar-emoji2.png"] forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:btn1];
    textField.rightView = vv;
    textField.rightViewMode = UITextFieldViewModeAlways;
    self.textField = textField;
    textField.placeholder = @"说点什么吧...";
    textField.delegate = self;
    [buttomV addSubview:textField];
    //==========================btn2====================
    UIButton * btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    btnright.frame = CGRectMake(SCREEN_SIZE.width-30, 7, 25,25);
    btnright.tag = 2;
    [btnright setBackgroundImage:[UIImage imageNamed:@"send.jpg"] forState:UIControlStateNormal];
    [btnright addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttomV addSubview:btnright];
    buttomV.hidden = YES;
    [self.view addSubview:buttomV];
    
}

-(void)creatQQkeyBoard
{
    self.expressV = (ExpressionView *)[[NSBundle mainBundle]loadNibNamed:@"ExpressionView" owner:nil options:nil][0];
    self.expressV.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 120);
    __weak typeof(self) weakSelf = self;
    self.expressV.textCallBlock = ^(NSString *text)
    {
        
        weakSelf.textField.text = [NSString stringWithFormat:@"%@%@",weakSelf.textField.text,text];
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
    
    self.textField.text =nil;

}

-(void)btnseleteAction:(UIButton *)sender
{
    
    
    if (self.textField.text.length>0)
    {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length-1];
        //        self.tipLabel.text = [NSString stringWithFormat:@"%ld/%ld字",self.textView.text.length+1, (long)MAXVALUE];
        
    }else{
        
        if (self.textField.text.length==0) {
           
           }
        
    }
    
}


-(void)btnAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            self.buttomV.hidden = YES;
            [self.textField resignFirstResponder];
            
            
        }
            break;
        case 1:
        {
           //自定义表情
            
            //改变键盘状态
               [self.textField becomeFirstResponder];
                self.isFace = !self.isFace;
                if (self.isFace) {
                 
                    self.textField.inputView = self.expressV;
                    
                }else
                {
                    self.textField.inputView = nil;
                }
                
                [self.textField reloadInputViews];
           
            
        }
            break;
        case 2:
        {
            if (self.textField.text.length == 0)
            {
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                [SVProgressHUD showInfoWithStatus:@"内容不能为空"];
            }else
            {
                //发送评论
                NSDictionary * dic = @{@"uid":@(USER_MODEL.userId),@"msg":self.textField.text,@"project":@(self.detailXMLModel.strID)};
                [self UpMyCommitData:dic andType:Comment];
            }
        }
            break;
        default:
            break;
    }
    
}





//上传评论
-(void)UpMyCommitData:(NSDictionary *)param andType:(typeStyle)typeStyle
{
    //上传数据，判断是否登录
    if (![[Tool readLoginState:LOGIN_STATE] isEqualToString:@"1"])
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:[Tool getNavigationController:loginVC andtransitioningDelegate:nil andNavigationViewControllerType:NavigationControllerMineType] animated:YES completion:nil];
        
    }else
    {
  
    
    NSString *strUrl;
    if (typeStyle == Favortie)
    {
        //判断添加还是删除
        if (self.isFavorite)
        {
            strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_FAVORITE_ADD];
        }else
        {
            strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_FAVORITE_DELETE];
        }
        
    }else
    {
        strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_SOFTWARE_TWEET_PUB];
        
    }
    
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
//        NSLog(@"========%@",responseObject);
        //类型转换
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;//根元素
        ONOXMLElement *softwares = [result firstChildWithTag:@"result"];
        int errorCode = [[[softwares firstChildWithTag:@"errorCode"] numberValue] intValue];
        NSString *errorMessage = [[result firstChildWithTag:@"errorMessage"] stringValue];
        if (errorCode == -1) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showInfoWithStatus:errorMessage];
        } else {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            
            if (typeStyle == Favortie)
            {
                
                if (self.isFavorite) {
                    [SVProgressHUD showInfoWithStatus:@"收藏添加成功"];
                    //设置收藏图片
                    [self.menuTool.btnFavorite setBackgroundImage:[UIImage imageNamed:@"toolbar-starred@2x"] forState:UIControlStateNormal];
                }else
                {
                    [SVProgressHUD showInfoWithStatus:@"收藏删除成功"];
                    //设置收藏图片
                    [self.menuTool.btnFavorite setBackgroundImage:[UIImage imageNamed:@"toolbar-star@2x"] forState:UIControlStateNormal];
                }
                self.isFavorite  =!self.isFavorite;
                
            }else
            {
                [SVProgressHUD showInfoWithStatus:@"恭喜您评论发送成功"];
            }
            
        }
        
        
    } andFailBlock:^(NSError *error) {
        
    }];
    
    }
}



//输入框代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
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
    self.buttomV.hidden = NO;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.buttomV.frame = CGRectMake(0, SCREEN_SIZE.height-45-kbSize.height, SCREEN_SIZE.width, 45);
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.buttomV.frame = CGRectMake(0, SCREEN_SIZE.height-45, SCREEN_SIZE.width, 45);
    
    
}

//菜单代理方法
-(void)doSomethingWithTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
        {
            self.buttomV.hidden =NO;
            
        }
            break;
        case 1:
        {
            //软件动弹列表
            SoftWareCommintViewController *softVC = [[SoftWareCommintViewController alloc]init];
            softVC.softId = self.detailXMLModel.strID;
            [self.navigationController pushViewController:softVC animated:YES];
            
        }
            break;
        case 2:
        {
            //弹出键盘
            [self.textField becomeFirstResponder];
            
        }
            break;
        case 3:
        {
            //收藏
            NSDictionary * dic = @{@"uid":@(USER_MODEL.userId),@"objid":@(self.detailXMLModel.strID),@"type":@(1)};
            [self UpMyCommitData:dic andType:Favortie];
            
            
        }
            break;
        case 4:
        {
            [UMSocialWechatHandler setWXAppId:@"wx6f2c2f302768cf07" appSecret:@"309d97f1e1da94fdb3427fad32fc2b5d" url:self.detailXMLModel.url];
            //微信、微信朋友圈
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.detailXMLModel.title;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = self.detailXMLModel.url;
            //QQ、QQ空间
            [UMSocialData defaultData].extConfig.qqData.url = self.detailXMLModel.url;
            [UMSocialData defaultData].extConfig.qzoneData.url = self.detailXMLModel.url;
            
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"5774e4aee0f55a0ae6001483"
                                              shareText:self.detailXMLModel.url
                                             shareImage:[UIImage imageNamed:@"10"]
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms]
                                               delegate:self];
            
        }
            break;
            
        default:
            break;
    }
    
}
//设置头部视图
-(void)setheadView
{
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(110 , 0, 196, 0);
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, -55, SCREEN_SIZE.width, 80)];
    lblTitle.font = [UIFont systemFontOfSize:20 weight:0.5];
    lblTitle.numberOfLines = 0;
    //创建文本附件包含图片
    NSTextAttachment *attachMent = [[NSTextAttachment alloc]init];
    //设置大小
    CGFloat height = lblTitle.font.lineHeight;
    //设置图片
    attachMent.image = [UIImage imageNamed:@"recommend_tag"];
    attachMent.bounds = CGRectMake(0, -7, height, height);
    //使用附件创建属性字符串
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:attachMent];
    //拼接文字
    NSString * str = [self.detailXMLModel.extensionTitle stringByAppendingString:self.detailXMLModel.title];
    //创建可变字符 拼接字符串
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc]initWithString:str];
    if (self.detailXMLModel.recommended == 4)
    {
        [strM appendAttributedString:attrString];
    }
    //获取logo
    UIImage *img = [self getImageFromURL:self.detailXMLModel.logo];
    NSTextAttachment *attachMentLogo = [[NSTextAttachment alloc]init];
    attachMentLogo.image = img;
    attachMentLogo.bounds = CGRectMake(0, -7, height, height);
    //使用附件创建属性字符串
    NSAttributedString *attrStringLogo = [NSAttributedString attributedStringWithAttachment:attachMentLogo];
    NSMutableAttributedString *strMLogo = [[NSMutableAttributedString alloc]initWithAttributedString:attrStringLogo];
    [strMLogo appendAttributedString:strM];
    //设置lable内容
    lblTitle.attributedText = strMLogo;
    [self.webView.scrollView addSubview:lblTitle];
    
    
}
//logo图片
-(UIImage*)getImageFromURL:(NSString*)fileURL
{
    NSURL *url = [NSURL URLWithString:fileURL];
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    UIImage *result = [UIImage imageWithData:data];
    return result;
}
//尾部视图
-(void)setfootView
{
    //加载xib
    DetailScrollFootView *footView = [[NSBundle mainBundle]loadNibNamed:@"DetailScrollFootView" owner:nil options:nil][0];
    self.footView = footView;
    footView.frame = CGRectMake(0, 700, SCREEN_SIZE.width, 194);
    [self.webView.scrollView addSubview:self.footView];
    footView.hidden = YES;
    footView.author.text = self.detailXMLModel.authorid;
    footView.deal.text = self.detailXMLModel.license;
    footView.language.text = self.detailXMLModel.language;
    footView.system.text = self.detailXMLModel.os;
    footView.time.text =self.detailXMLModel.recordtime;
    footView.footBlock = ^(NSInteger tagV)
    {
        switch (tagV) {
            case 1:
            {
                
                DetailSecondController *detailVC = [[DetailSecondController alloc]init];
                detailVC.detailTitlt = self.detailXMLModel.title;
                detailVC.url =self.detailXMLModel.homepage;
                [self.navigationController pushViewController:detailVC animated:YES];
                
            }
                break;
            case 2:
            {
                
                DetailSecondController *detailVC = [[DetailSecondController alloc]init];
                detailVC.detailTitlt = self.detailXMLModel.title;
                detailVC.url =self.detailXMLModel.document;
                [self.navigationController pushViewController:detailVC animated:YES];
                
            }
                break;
            case 3:
            {
                DetailSecondController *detailVC = [[DetailSecondController alloc]init];
                detailVC.detailTitlt = self.detailXMLModel.title;
                detailVC.url =self.detailXMLModel.download;
                [self.navigationController pushViewController:detailVC animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    };
    
}

-(void)loadMyDataDict:(NSDictionary *)param
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",URL_HTTP_PREFIX,URL_SOFTWARE_DETAIL];
    
    [LoadModel postRequestWithUrl:strUrl andParams:param andSucBlock:^(id responseObject) {
        
        //类型转换
        ONOXMLDocument *obj = responseObject;
        ONOXMLElement *result = obj.rootElement;//根元素
        ONOXMLElement *softwares = [result firstChildWithTag:@"software"];
        //转模型
        self.detailXMLModel = [[DetailXMLModel alloc]initWithXML:softwares];
        [self setUp];
        if (self.detailXMLModel.body == nil) return ;
        //下载评论个数
        NSDictionary *dic2 = @{@"project":@(self.detailXMLModel.strID),@"pageIndex":@(0),@"pageSize":@(20)};
        
        [self loadCount:dic2];
        //设置头部视图
        [self setheadView];
        //设置尾部视图
        [self setfootView];
        
        
    } andFailBlock:^(NSError *error) {
        NSLog(@"err:%@",error);
    }];
    
    
}
-(void)setUp
{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    if (self.detailXMLModel.body == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"没有相关的详情"];
        return;
    }
    NSString *str1 = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>",(SCREEN_SIZE.width*0.95)];
    [self.webView loadHTMLString:[str1 stringByAppendingString:self.detailXMLModel.body]  baseURL:nil];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.footView.frame = CGRectMake(0, self.webView.scrollView.contentSize.height, SCREEN_SIZE.width, 194);
    
    self.footView.hidden = NO;
}
-(MenuTool*)menuTool
{
    if (_menuTool == nil)
    {
        _menuTool = [[NSBundle mainBundle] loadNibNamed:@"MenuTool" owner:nil options:nil][1];
        _menuTool.frame = CGRectMake(0, SCREEN_SIZE.height-45, SCREEN_SIZE.width, 45);
        _menuTool.gDelegate = self;
        
    }
    return  _menuTool;
}


@end
