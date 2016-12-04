//
//  Tool.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 One. All rights reserved.
//

#import "Tool.h"
#import "NavigationViewController.h"
#import "Reachability.h"
#import "InteractivityTransitionDelegate.h"
@implementation Tool
+ (InteractivityTransitionDelegate *)getInteractivityTransitionDelegateWithType:(InteractivityTransitionDelegateType)type
{
    switch (type) {
        case InteractivityTransitionDelegateTypeNormal:
            return [[InteractivityTransitionDelegate alloc]initWithType:TransitionAnimatorTypeNavigation];
            break;
        case InteractivityTransitionDelegateTypeMenu:
            return [[InteractivityTransitionDelegate alloc]initWithType:TransitionAnimatorTypeMine];
            break;
        default:
            break;
    }
    return [[InteractivityTransitionDelegate alloc]initWithType:TransitionAnimatorTypeNavigation];
}
/**
 *  根据图片名称获取保持原来样式的图片对象
 *
 *  @param imgName 图片名称
 *
 *  @return 返回图片对象
 */
+(UIImage *)getRendingImageWithName:(NSString *)imgName
{
    // 创建图片
    UIImage *img = [UIImage imageNamed:imgName];
    // 返回设置好的图片
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  获取导航栏控制器
 *
 *  @param viewController 导航栏的根视图控制器
 *
 *  @return 返回导航栏控制器
 */
+ (UINavigationController *) getNavigationController:(UIViewController *)viewController andtransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)delegate andNavigationViewControllerType:(NavigationControllerType)navigationControllerType
{
    UINavigationController *naVC;
    switch (navigationControllerType) {
        case NavigationControllerSystemType:
            naVC = [[UINavigationController alloc]initWithRootViewController:viewController];
            break;
        case NavigationControllerMineType:
            naVC = [[MineNavigationViewController alloc]initWithRootViewController:viewController];
            viewController.transitioningDelegate = delegate;
            break;
        case NavigationControllerNormalType:
            naVC = [[NavigationViewController alloc]initWithRootViewController:viewController];
            break;

        default:
            naVC = [[UINavigationController alloc]initWithRootViewController:viewController];
            break;
    }
    if (delegate != nil) {
        naVC.transitioningDelegate = delegate;
        naVC.modalTransitionStyle = UIModalPresentationCustom;
    }
    return naVC;
}
#pragma mark -- 缓存
+(void)writeToUserD:(id)obj andKey:(NSString *)key
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:obj forKey:key];
    [userD synchronize];
}
+(id)readFromUserD:(NSString *)key
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    return [userD objectForKey:key];
}
#pragma mark -- 存储用户登入状态 1 表示登入  0 表示未登入
// 存储用户登入状态 1 表示登入  0 表示未登入
+(void)writeLoginState:(id)obj andKey:(NSString *)key
{
    // 获取NSUserDefaults单例
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    // 将对象存入NSUserDefaults单例
    [userD setObject:obj forKey:key];
    // 保持写入的线程同步，保证线程安全
    [userD synchronize];
}
+(id)readLoginState:(NSString *)key
{
    // 获取NSUserDefaults单例
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
//     返回存储的对象数据
    return [userD objectForKey:key];
}

#pragma mark -- obj归档 存缓存
+ (void)writeData:(id)obj toArchiveWithKey:(NSString *)key
{
    NSData *data = [self archiveObj:obj withKey:key];
    [self writeToUserD:data andKey:key];
}
/** 通过解档读取缓存 */
+ (id)readDataFromUnArchiveWithKey:(NSString *)key
{
    NSMutableData *data1 = [self readFromUserD:key];
    if(data1==nil){//如果沙盒内本来就没有对应key的数据直接返回nil
        return nil;
    }else{
        id obj=[self unArchiveObj:data1 withKey:key];
        return obj;
    }
}
#pragma mark -- 归档

+ (NSData *)archiveObj:(id)obj withKey:(NSString *)key
{
    NSMutableData *data = [NSMutableData new];
    NSKeyedArchiver *keyedA = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [keyedA encodeObject:obj forKey:key];
    [keyedA finishEncoding];
    return data;
}

+ (id)unArchiveObj:(NSData *)data withKey:(NSString *)key
{
    NSKeyedUnarchiver *keyedUnA = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    id obj = [keyedUnA decodeObjectForKey:key];
    [keyedUnA finishDecoding];
    return obj;
}
// 返回特定背景颜色的UIImage
+ (UIImage *)imageWithBGColor:(UIColor *)color
{
    CGRect imgRect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(imgRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, imgRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (NSData *)compressImage:(UIImage *)image
{
    CGSize size = [self scaleSize:image.size];
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSUInteger maxFileSize = 500 * 1024;
    CGFloat compressionRatio = 0.7f;
    CGFloat maxCompressionRatio = 0.1f;
    
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, compressionRatio);
    
    while (imageData.length > maxFileSize && compressionRatio > maxCompressionRatio) {
        compressionRatio -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compressionRatio);
    }
    
    return imageData;
}

+ (CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height) {
        return CGSizeMake(800, 800 * height / width);
    } else {
        return CGSizeMake(800 * width / height, 800);
    }
}

/*
 1 声明CIFilter的输入参数，每个输入参数名都应当以input开头，比如inputImage
 
 2 如果必要的话重载setDefaults方法（本例中由于输入参数为set值，所以不需要）
 
 3 重载outputImage方法
 */
+ (CIImage *)createQRForString:(NSString *)qrString {
    //转成data
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter，反正创建二维码，用这个字符串
    //生成二维码用到了 CIQRCodeGenerator 这种 CIFilter。它有两个字段可以设置，inputMessage 和 inputCorrectionLevel。inputMessage 是一个 NSData 对象，可以是字符串也可以是一个 URL。inputCorrectionLevel 是一个单字母（@"L", @"M", @"Q", @"H" 中的一个），表示不同级别的容错率，默认为 @"M"。
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    //    //QR码图形面积愈大。所以一般折衷使用15%容错能力。
    //
    //    错误修正容量 L水平 7%的字码可被修正
    //
    //    M水平 15%的字码可被修正
    //
    //    Q水平 25%的字码可被修正
    //
    //    H水平 30%的字码可被修正
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}
//因为生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用下面方法返回需要大小的UIImage：
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
// 将字符串转成指定大小的二维码图片
+ (UIImage *)createQRWithString:(NSString *)qrString andSize:(CGFloat) size
{
    return [self avatarImage:[self createNonInterpolatedUIImageFormCIImage:[self createQRForString:qrString] withSize:size]];
}

+ (UIImage *) avatarImage:(UIImage *)avatarImage
{
    
    UIImage * avatarBackgroudImage = [UIImage imageNamed:@"head.jpg"];
    
    CGSize size = avatarBackgroudImage.size;
    
    UIGraphicsBeginImageContext(size);
    
    
    
    [avatarBackgroudImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    [avatarImage drawInRect:CGRectMake(10, 10, size.width - 20, size.height - 20)];
    
    
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
    
}
/**
 *  弹出提示框
 *
 *  @param title     提示标题
 *  @param message   提示信息
 *  @param presentVC 弹出提示框的视图控制器
 */
+(void) showAlertControllerWithTitle:(NSString *)title
                          andMessage:(NSString *)message
          andPresentUIViewController:(UIViewController *)presentVC
{
    //创建提示框控制器（iOS8之后改的）
    //style有两种：UIAlertControllerStyleAlert，UIAlertControllerStyleActionSheet
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //创建确定按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil];
    //提示控制器添加确定删除按钮
    [alertVC addAction:okAction];
    [presentVC presentViewController:alertVC animated:YES completion:nil];
    
}

/***
 * 此函数用来判断是否网络连接服务器正常
 * 需要导入Reachability类
 */
+ (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];  // 测试服务器状态
    
    switch([reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
    }
    return  isExistenceNetwork;
}

+ (void)showNetWorkState
{
    if (![self isExistenceNetwork])
    {
        [SVProgressHUD showImage:Image(@"icon_net_empty") status:@"无网络"];
    }
}
@end
