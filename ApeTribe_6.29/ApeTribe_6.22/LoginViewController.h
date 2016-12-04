//
//  LoginViewController.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Config.h"
//#import "Ono.h"
//#import "Tool.h"
//#import "URL.h"

@interface LoginViewController : UIViewController
@property (strong, nonatomic) UITextField *phoneTextField;// 手机号
@property (strong, nonatomic) UITextField *passwordTextField;// 用户密码
@property (strong, nonatomic) UIButton *enrollButton, *forgetPwdButton;// 注册
@property (strong, nonatomic) UIImageView *titleImgV, *logoImgV, *phoneImgV, *passwordImgV;// 应用标语,应用logo，手机号logo，密码logo
@property (strong, nonatomic) UILabel *phoneBG, *passwardBG, *phoneBG1, *passwardBG1;// 手机号输入框背景，密码输入框背景
@property (strong, nonatomic) UIButton *loginButton, *weChatLoginButton, *weiboLoginButton, *qqLoginButton;// 登录
@property (assign, nonatomic) BOOL keyboardIsVisible;// 判断键盘是否弹出
@end
