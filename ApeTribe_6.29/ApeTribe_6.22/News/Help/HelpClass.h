//
//  HelpClass.h
//  GGIcome
//
//  Created by gg on 16/5/22.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HelpClass : NSObject
//判断是否是今天
+(NSString *)compareDate:(NSDate *)date;
//时间转换成几小时前
+ (NSString *) compareCurrentTime:(NSString *)str;
//给一个文件名，获取沙盒的路径
+(NSString *)getPathWithFileName:(NSString*)fileName;


+(NSString *)getCurrentDate;
+(NSString *)getOrderID;

+(NSString*)getOrderNumber;
//获取手机电话号码
+(NSString *)myNumber;

//判断手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber;

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name;

//时间转换成几小时前
//+ (NSString *) compareCurrentTime:(NSString *)str;


+(void)warning:(NSString*)text andView:(UIView*)view andHideTime:(double)time;

+(NSDictionary*)getUserDict;
+(NSString *)getAccessToken;
+(NSString *)getUserId;
+(NSString *)getUserCustomerId;

@end
