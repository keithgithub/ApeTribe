//
//  Tool.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationViewController.h"
#import "InteractivityTransitionDelegate.h"
typedef enum : NSUInteger {
    NavigationControllerSystemType,
    NavigationControllerMineType,
    NavigationControllerNormalType,
} NavigationControllerType;
/**
 自定义转场的代理类型
 */
typedef enum : NSUInteger {
    InteractivityTransitionDelegateTypeNormal,
    InteractivityTransitionDelegateTypeMenu,
    
} InteractivityTransitionDelegateType;


@interface Tool : NSObject
/**
 *  获取自定义转场动画代理
 *
 *  @param type 代理类型
 *
 *  @return 代理对象
 */
+ (InteractivityTransitionDelegate *)getInteractivityTransitionDelegateWithType:(InteractivityTransitionDelegateType)type;
/**
 *  根据图片名称获取保持原来样式的图片对象
 *
 *  @param imgName 图片名称
 *
 *  @return 返回图片对象
 */
+(UIImage *)getRendingImageWithName:(NSString *)imgName;
/**
 *  获取导航栏控制器
 *
 *  @param viewController 导航栏的根视图控制器
 *
 *  @return 返回导航栏控制器
 */
+ (UINavigationController *) getNavigationController:(UIViewController *)viewController andtransitioningDelegate:(id<UIViewControllerTransitioningDelegate>) delegate andNavigationViewControllerType:(NavigationControllerType)navigationControllerType;

// 缓存
+(void)writeToUserD:(id)obj andKey:(NSString *)key;
+(id)readFromUserD:(NSString *)key;

//存储用户登入状态
// // 设置为登入状态
// [Methods writeLoginState:@"1" andKey:@"loginState"];
//  // 设置为退出登入状态
// [Methods writeLoginState:@"0" andKey:@"loginState"];
+(void)writeLoginState:(id)obj andKey:(NSString *)key;
+(id)readLoginState:(NSString *)key;

#pragma mark -- obj归档 存缓存
+ (void)writeData:(id)obj toArchiveWithKey:(NSString *)key;
+ (id)readDataFromUnArchiveWithKey:(NSString *)key;
#pragma mark -- 归档
+ (NSData *)archiveObj:(id)obj withKey:(NSString *)key;
+ (id)unArchiveObj:(NSData *)data withKey:(NSString *)key;
// 返回特定背景颜色的UIImage
+(UIImage *)imageWithBGColor:(UIColor *)color;
// 图片转data
+ (NSData *)compressImage:(UIImage *)image;
// 图片压缩
+ (CGSize)scaleSize:(CGSize)sourceSize;

+ (CIImage *)createQRForString:(NSString *)qrString;
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

+ (UIImage *)createQRWithString:(NSString *)qrString andSize:(CGFloat) size;
/**
 *  弹出提示框
 *
 *  @param title     提示标题
 *  @param message   提示信息
 *  @param presentVC 弹出提示框的视图控制器
 */
+(void) showAlertControllerWithTitle:(NSString *)title
                          andMessage:(NSString *)message
          andPresentUIViewController:(UIViewController *)presentVC;
/***
 * 此函数用来判断是否网络连接服务器正常
 * 需要导入Reachability类
 */
+ (BOOL)isExistenceNetwork;
+ (void) showNetWorkState;
@end
