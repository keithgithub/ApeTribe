//
//  Config.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/22.
//  Copyright © 2016年 One. All rights reserved.
//

#ifndef Config_h
#define Config_h

#ifdef DEBUG //处于开发阶段
#define NSLog(...)  NSLog(__VA_ARGS__)
#else//处于发布阶段--build conguration 设置为release模式
#define NSLog(...)
#endif

//获取AppDelegate
#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
//单例
#define USER_MODEL ([UserInfoXMLModel sharedUserInfoXMLModel])// 用户
#define USER_KEY @"user_osChina"// 用户key
#define USER_ID_KEY  @"userId"
#define ACCESS_TOKEN_KEY @"accessToken"
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define FINISH_LOAD_DATA @"finishLoadData"
#define LOGIN_STATE @"loginState"// 0：未登录  1：登录
#define LOGIN_INFO @"loginInfo"// 登录信息用户名和账号
#define ACCESS_TOKEN [Tool readFromUserD:ACCESS_TOKEN_KEY]
#define URL_STR(server,list) ([NSString stringWithFormat:@"%@/%@",server,list])
#define URL(strURL) [NSURL URLWithString:strURL]
//设备宽
#define IPHONE_W ([UIScreen mainScreen].bounds.size.width)
//设备高
#define IPHONE_H ([UIScreen mainScreen].bounds.size.height)
//屏幕宽高
#define SCREEN_W (self.view.frame.size.width)
#define SCREEN_H (self.view.frame.size.height)
//View宽高
#define  VIEW_H  self.frame.size.height
#define  VIEW_W  self.frame.size.width
// 边距
#define MARGIN (IPHONE_W/32)

#define LOGIN_ORI_Y (IPHONE_W == 320 ? 200 : IPHONE_W == 375? 300 : 320 ) //最小字体

//定义UIImage对象
#define IMAGE(file) ([UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:file ofType:nil］)

//storyboard,NAME为storyboard名
#define STORYBOARD(NAME) [UIStoryboard storyboardWithName:NAME bundle:nil]
//图片
#define Image(imgName) [UIImage imageNamed:imgName]
//字体
#define FONT(SIZE) [UIFont systemFontOfSize:SIZE]

#define MINIFONT (IPHONE_W == 320?[UIFont systemFontOfSize:13.0f]:IPHONE_W == 375? [UIFont systemFontOfSize:14.0f]:[UIFont systemFontOfSize:16.0f]) //最小字体

#define MAINFONT (IPHONE_W == 320?[UIFont systemFontOfSize:15.0f]:IPHONE_W == 375? [UIFont systemFontOfSize:17.0f]:[UIFont systemFontOfSize:20.0f]) //按钮字体

#define BARFONT (IPHONE_W == 320?[UIFont systemFontOfSize:18.0f]:IPHONE_W == 375? [UIFont systemFontOfSize:20.0f]:[UIFont systemFontOfSize:25.0f]) //导航栏字体

#define NOTEFONT (IPHONE_W == 320?[UIFont systemFontOfSize:14.0f]:IPHONE_W == 375? [UIFont systemFontOfSize:16.0f]:[UIFont systemFontOfSize:18.0f]) //注释字体
#define HOMECELL_FONT [UIFont systemFontOfSize:15.0f]

// 字体颜色
#define COLOR_FONT_L_GRAY [UIColor colorWithWhite:0.600 alpha:1.000]// 浅灰
#define COLOR_FONT_D_GRAY [UIColor colorWithWhite:0.400 alpha:1.000]// 深灰（标题）
//#define COLOR_FONT_D_GREEN [UIColor colorWithRed:1.000 green:0.366 blue:0.574 alpha:1.000]// 浅绿（标题）
#define COLOR_FONT_D_GREEN [UIColor colorWithRed:0.176 green:0.729 blue:0.412 alpha:1.000]// 浅绿（标题）
// 背景颜色
#define COLOR_BG_L_GRAY [UIColor colorWithWhite:0.800 alpha:1.000]// 浅灰
#define COLOR_BG_D_GRAY [UIColor colorWithWhite:0.902 alpha:1.000]// 深灰
#define COLOR_BG_LINE_GRAY [UIColor colorWithWhite:0.498 alpha:1.000]
#define COLOR_BG_D_GREEN [UIColor colorWithRed:0.227 green:0.592 blue:0.000 alpha:1.000]// 军绿色

#endif /* Config_h */
