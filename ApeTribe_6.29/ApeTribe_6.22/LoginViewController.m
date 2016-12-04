//
//  LoginViewController.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import "LoginViewController.h"
#import "UIButton+Extension.h"

#define BTN_R 3


@interface LoginViewController ()<UITextFieldDelegate,UIWebViewDelegate>
{
//    UIWebView *webView;
    BOOL didStartLogin;
}
@property (strong, nonatomic) UILabel  *otherLoginLb;// 第三方登录
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation LoginViewController

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    UIImageView *bgImgV= [[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgImgV setImage:Image(@"guide2-bg")];
    [self.view addSubview:bgImgV];
    [self.view sendSubviewToBack:bgImgV];
    // 设置导航栏背景透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏阴影透明
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [self.view addSubview:effectView];
    
    [self initial];
    // 自动登录
    [self readDataOfLastLoginInfo];
}

- (void) viewWillAppear:(BOOL)animated
{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 注销键盘的监听
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self dismissKeyboard:nil];
    [super viewWillDisappear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - init

- (void) initial
{
    _webView= [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.hidden = YES;
    [self.view addSubview:_webView];
    
    
    // 返回按钮
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:Image(@"topbar_white_close_normal") style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [self.navigationItem setRightBarButtonItem:backItem];
    
    // ==========登录==========
    CGFloat leading = 30.0;
    // 登录按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setWithFrame:CGRectMake(leading, LOGIN_ORI_Y, self.view.frame.size.width - leading * 2, 44) andTitle:@"登录" andColor:COLOR_FONT_D_GREEN andFont:[UIFont systemFontOfSize:18] andStyle:MyButtonColorBackgroundStyle];
    self.loginButton.tag = 500;
    self.loginButton.enabled = NO;
    self.loginButton.layer.cornerRadius = BTN_R;
    [self.loginButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 手机号输入框背景
    self.phoneBG = [[UILabel alloc]init];
    [self.phoneBG borderWithFrame:CGRectMake(leading, self.loginButton.frame.origin.y - 100, self.view.frame.size.width - leading * 2, 44) andColor:[UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:1.000] andBorderWidth:1 andCornerRadius:BTN_R];
//    self.phoneBG.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    self.phoneBG.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:0.104];
    // 密码输入框背景
    self.passwardBG = [[UILabel alloc]init];
    [self.passwardBG borderWithFrame:CGRectMake(leading, self.phoneBG.frame.origin.y + 50, self.view.frame.size.width - leading * 2, 44) andColor:[UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:1.000] andBorderWidth:1 andCornerRadius:BTN_R];
//    self.passwardBG.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    self.passwardBG.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:0.095];
    // 手机号logo
    self.phoneImgV = [[UIImageView alloc]initWithFrame:CGRectMake(46, 192 + 64, 30, 30)];
    self.phoneImgV.image = [UIImage imageNamed:@"tabbar-me-selected1"];
    
    // 密码logo
    self.passwordImgV = [[UIImageView alloc]initWithFrame:CGRectMake(46, 236 + 64, 30, 30)];
    self.passwordImgV.image = [UIImage imageNamed:@"密码1"];
    

    // 手机号输入框
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(38, 192 + 64, self.view.frame.size.width - 40 - 35, 30)];
    self.phoneTextField.tag = 501;
    self.phoneTextField.center = CGPointMake(self.phoneTextField.center.x, self.phoneBG.center.y);
    
    // 设置代理属性
    self.phoneTextField.delegate = self;
    // 设置键盘类型
//    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    // 设置键盘返回按钮的类型
    self.phoneTextField.returnKeyType = UIReturnKeyNext;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIColor *color = [UIColor colorWithWhite:0.678 alpha:1.000];
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"邮箱" attributes:@{NSForegroundColorAttributeName: color}];
    
   
    
    // 密码输入框
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(38, 236 + 64, self.view.frame.size.width - 40 - 35, 30)];
    
    self.passwordTextField.center = CGPointMake(self.passwordTextField.center.x, self.passwardBG.center.y);
    self.passwordTextField.tag = 502;
    // 设置光标颜色
    //    self.passwordTextField.tintColor = [UIColor grayColor];
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 设置隐藏密码
    self.passwordTextField.secureTextEntry = YES;
    // 设置键盘返回按钮的类型
    self.passwordTextField.returnKeyType = UIReturnKeyGo;
    // 设置代理属性
    self.passwordTextField.delegate = self;
    // 设置提示文字
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: color}];

    
    // 创建点击手势识别器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    // 创建点击手势识别器
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];// 添加点击的手势识别器
    [self.view addGestureRecognizer:pan];// 添加点击的手势识别器
    
    // ========第三方登录=========
    UIColor *otherLoginColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    // 其他登录方式
    self.otherLoginLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 21)];
    self.otherLoginLb.center = CGPointMake(SCREEN_W/ 2.0, self.loginButton.frame.origin.y + 100);
    self.otherLoginLb.text = @"第三方登录";
    self.otherLoginLb.textAlignment = NSTextAlignmentCenter;
    self.otherLoginLb.font = [UIFont systemFontOfSize:14];
    self.otherLoginLb.textColor = otherLoginColor;
    
    // 水平横线
    UILabel *line1 = [[UILabel alloc]init];
    [line1 lineWithColor:otherLoginColor andLength:(SCREEN_W - self.otherLoginLb.frame.size.width) / 2.0 andOriginX:0 andOriginY:0 andStyle:UILabelhorizontalLineStyle];
    line1.center = CGPointMake(line1.center.x, self.otherLoginLb.center.y);
    UILabel *line2 = [[UILabel alloc]init];
    [line2 lineWithColor:otherLoginColor andLength:(SCREEN_W - self.otherLoginLb.frame.size.width) / 2.0 andOriginX:self.otherLoginLb.frame.origin.x + self.otherLoginLb.frame.size.width andOriginY:0 andStyle:UILabelhorizontalLineStyle];
    line2.center = CGPointMake(line2.center.x, self.otherLoginLb.center.y);
    UILabel *line3 = [[UILabel alloc]init];
    [line3 lineWithColor:otherLoginColor andLength:self.view.frame.size.width andOriginX:0 andOriginY:self.otherLoginLb.frame.origin.y + 120 andStyle:UILabelhorizontalLineStyle];
    
    // =======第三方登录按钮=======
    CGFloat btnWidth = 100;
    self.weiboLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.weiboLoginButton.frame = CGRectMake((SCREEN_W - 3 * btnWidth) / 6, 0, btnWidth, btnWidth);
    self.weiboLoginButton.center = CGPointMake(self.weiboLoginButton.center.x, (line1.frame.origin.y + line3.frame.origin.y)/2.0);
    [self.weiboLoginButton setImage:[Tool getRendingImageWithName:@"login_sina_icon"] forState:UIControlStateNormal];
    
    self.qqLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.qqLoginButton.frame = CGRectMake((SCREEN_W - 3 * btnWidth) * 3 / 6 + btnWidth, 0, btnWidth, btnWidth);
    self.qqLoginButton.center = CGPointMake(self.qqLoginButton.center.x, (line1.frame.origin.y + line3.frame.origin.y)/2.0);
    [self.qqLoginButton setImage:[Tool getRendingImageWithName:@"login_qq_icon"] forState:UIControlStateNormal];
    
    self.weChatLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.weChatLoginButton.frame = CGRectMake((SCREEN_W - 3 * btnWidth) * 5/ 6 + btnWidth * 2, 0, btnWidth, btnWidth);
    self.weChatLoginButton.center = CGPointMake(self.weChatLoginButton.center.x, (line1.frame.origin.y + line3.frame.origin.y)/2.0);
    [self.weChatLoginButton setImage:[Tool getRendingImageWithName:@"login_wechat_icon"] forState:UIControlStateNormal];
    
    // 添加视图
    [self.view addSubview:self.logoImgV];
    [self.view addSubview:self.titleImgV];
    [self.view addSubview:self.phoneBG];
    [self.view addSubview:self.passwardBG];
    [self.view addSubview:self.phoneImgV];
    [self.view addSubview:self.passwordImgV];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
//    [self.view addSubview:self.forgetPwdButton];
//    [self.view addSubview:self.enrollButton];
    // 第三方登录
//    [self.view addSubview:_otherLoginLb];
//    [self.view addSubview:line1];
//    [self.view addSubview:line2];
//    [self.view addSubview:line3];
//    [self.view addSubview:self.weiboLoginButton];
//    [self.view addSubview:self.weChatLoginButton];
//    [self.view addSubview:self.qqLoginButton];
    
    // 读取用户上一次登录信息
    [self readDataOfLastLoginInfo];
    
}
// 点击
- (void) dismissKeyboard:(UIGestureRecognizer *)sender
{
    // 回收键盘
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
#pragma mark - action
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 设置电池栏的前景颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)keyboardDidShow
{
    _keyboardIsVisible = YES;
    int offset = self.loginButton.frame.origin.y + 70 - (self.view.frame.size.height - 216.0);//iPhone键盘高度216，iPad的为352
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
    {
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3f];
        self.view.frame = CGRectMake(0.0f, -offset + 30, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

- (void)keyboardDidHide
{
    _keyboardIsVisible = NO;
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
// 获取键盘是否弹出的标识
- (BOOL)keyboardIsVisible
{
    return _keyboardIsVisible;
}

- (void)btnAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 500:
            if (!didStartLogin) {
                // 登录
                [self login];
            }
            break;
        case 104:// 注册
        {
           
        }
            break;
        case 105:// 忘记密码
        {
//            // 创建更新密码的界面
//            UpdatePwdViewController *updatePwdVC = [[UpdatePwdViewController alloc]init];
//            // 跳转
//            [self.navigationController pushViewController:updatePwdVC animated:YES];
        }
            
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置登录按钮是否可以响应单击
- (void) setLoginButtonState
{
    // 判断当输入框的内容都不为空时才可以点击登录按钮
    if (self.phoneTextField.text.length != 0 && self.passwordTextField.text.length != 0) {
        [self.loginButton setEnabled:YES];
    }else{
        [self.loginButton setEnabled:NO];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldClear:(UITextField *)textField
{
    [self setLoginButtonState];
    return YES;
}
// 输入框内容改变时调用的方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self setLoginButtonState];
    return YES;
}

// 文本输入框开始编辑的时候调用的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    if (textField.tag == 501) {
        self.phoneBG.layer.borderColor = [UIColor colorWithRed:0.002 green:0.600 blue:0.003 alpha:1.000].CGColor;
        self.phoneBG.layer.borderWidth = 2;
    }
    if (textField.tag == 502) {
        self.passwardBG.layer.borderColor = [UIColor colorWithRed:0.002 green:0.600 blue:0.003 alpha:1.000].CGColor;
        self.passwardBG.layer.borderWidth = 2;
    }
    [self setLoginButtonState];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 501) {
        self.phoneBG.layer.borderColor = [UIColor colorWithRed:0.002 green:0.700 blue:0.003 alpha:1.000].CGColor;
        self.phoneBG.layer.borderWidth = 1;
       
    }
    if (textField.tag == 502) {
        
        self.passwardBG.layer.borderColor = [UIColor colorWithRed:0.002 green:0.700 blue:0.003 alpha:1.000].CGColor;
        self.passwardBG.layer.borderWidth = 1;
    }

}
// 点击返回按钮响应的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 200)
    {
        [self.passwordTextField becomeFirstResponder];// 将密码文本输入框设置为第一响应者
    }
    else
    {
        [textField resignFirstResponder];// 回收键盘
//        [self login];// 登录
    }
    
    return YES;
    
}

#pragma mark - UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1. 获得请求路径
    NSString *url = request.URL.absoluteString;
    NSLog(@"<<<url:%@",url);
    //判断是code回调的地址做截取code的值
    if ([url  hasPrefix:@"http://www.iosschool.org/auth/index.php?code="])
    {
        //网页停止加载
        [_webView  stopLoading];
        //获取code的位置
        NSRange range = [url  rangeOfString:@"code="];
        
        //获取code的值
        NSString *code =[url  substringFromIndex:range.location+range.length];
        //发送请求进行认证登录
        NSMutableString *urlStr = [[NSMutableString alloc]initWithString:kAccessTokenURL];
        [urlStr appendString:LOGINPARAM];
        [urlStr appendString:code];
        //请求
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        NSURLSession *session =[NSURLSession  sharedSession];
        __weak typeof(self) weakself = self;
        NSURLSessionTask *task =[session   dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"----%@",[[NSString alloc] initWithData:data encoding:4]);
            /**
             *  返回结果
             *  <?xml version="1.0" encoding="UTF-8"?><oschina><token><accessToken>1bd8107a-5c1b-407c-89be-16a39c880b36</accessToken><refresh_token>3819e41b-0b14-4be2-9bf9-eef91a3035b5</refresh_token><tokenType>bearer</tokenType><expiresIn>604799</expiresIn></token><uid>2775513</uid></oschina>
             */
            
            
            
            ONOXMLDocument *docu = [ONOXMLDocument XMLDocumentWithData:data error:nil];
            ONOXMLElement *root = docu.rootElement;
            ONOXMLElement *token = [root firstChildWithTag:@"token"];
            NSString *accessToken = [[token firstChildWithTag:@"accessToken"]stringValue];
            NSLog(@"root === %@",docu);
            NSLog(@"accessToken = %@",accessToken);
            
            if (accessToken != nil)
            {
                // =========登录成功========
                [Tool writeToUserD:accessToken andKey:ACCESS_TOKEN_KEY];
                
                // 设置用户状态为登录状态
                [Tool writeLoginState:@"1" andKey:@"loginState"];
                [Tool writeLoginState:@"1" andKey:LOGIN_STATE];
                
                // 发送登录状态的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                
                // 用户登录信息放入缓存
                NSMutableDictionary *loginInfo = [NSMutableDictionary new];
                [loginInfo setObject:weakself.phoneTextField.text forKey:@"email"];
                [loginInfo setObject:weakself.passwordTextField.text forKey:@"password"];
                
                
                [Tool writeToUserD:loginInfo andKey:@"loginInfo"];
                
                [SVProgressHUD dismiss];
                
                // 情况webView的cookie缓存
                NSHTTPCookieStorage *cookiesStorge=[NSHTTPCookieStorage sharedHTTPCookieStorage];
                for (NSHTTPCookie *cookie in [cookiesStorge cookies])
                {
                    [cookiesStorge deleteCookie:cookie];
                }
                
                [weakself dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
                didStartLogin = NO;
                // =========登录失败========
            }
        }];
        [task  resume];
        
        
        
        
    }

    return YES;
}
// 开始加载
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    
}

// 加载完成
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    NSString *url = webView.request.URL.absoluteString;
    if (![url  hasPrefix:@"http://www.iosschool.org/auth/index.php?code="])
    {
//        [webView stringByEvaluatingJavaScriptFromString:AGAINJS];
        
  
        //执行js脚本
        //        [webView  stringByEvaluatingJavaScriptFromString:JS(@"815009254@qq.com", @"00pp..")];
        //        self.phoneTextField.text = @"815009254@qq.com";
        //        self.passwordTextField.text = @"00pp..";
        //执行js脚本
        [webView  stringByEvaluatingJavaScriptFromString:JS(self.phoneTextField.text, self.passwordTextField.text)];
        NSLog(@"999");
    }

}
// 加载失败
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"网页加载失败");
}

#pragma mark - private
// 获取上一次的登录信息
-(void)readDataOfLastLoginInfo
{
    NSDictionary *dict = [Tool readFromUserD:@"loginInfo"];
    self.phoneTextField.text = dict[@"email"];
    self.passwordTextField.text = dict[@"password"];
}

// 登录
- (void)login
{
    
    // 请求登录
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:OAUTH2_URL]];
    [_webView loadRequest:request];
    
    [SVProgressHUD showWithStatus:@"正在登陆部落"];
}



@end
