//
//  HelpClass.m
//  GGIcome
//
//  Created by gg on 16/5/22.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "HelpClass.h"
#import "MBProgressHUD.h"
#import <CoreTelephony/CoreTelephonyDefines.h>

extern NSString *CTSettingCopyMyPhoneNumber();

@implementation HelpClass

//提示

//时间转换成几小时前
+ (NSString *) compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = - timeInterval;
    //标准时间和北京时间差8个小时
//    timeInterval = timeInterval + 8*60*60;
    long temp = 0;
    NSString *result;
    //判断
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
//判断是否是今天
+(NSString *)compareDate:(NSDate *)date
{
    
    NSTimeInterval secondsPerDay = 16 * 60 * 60;
    NSDate *today = [[NSDate alloc]init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}
//给一个文件名，获取沙盒的路径
+(NSString *)getPathWithFileName:(NSString*)fileName
{
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [docs[0]stringByAppendingPathComponent:fileName];
    return filePath;
}


+(NSString *)getCurrentDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format stringFromDate:date];
}
+(NSString *)getOrderID
{
    NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    [dateF setDateStyle:NSDateFormatterMediumStyle];
    [dateF setTimeStyle:NSDateFormatterShortStyle];
    [dateF setDateFormat:@"yyyyMMddHHmmssSSS"];//精确到毫秒
    NSMutableString *OrderIdStr = [NSMutableString stringWithString:@"XS_"];
    [OrderIdStr appendString:[dateF stringFromDate:[NSDate date]]];
    NSLog(@"%@",OrderIdStr);
    return OrderIdStr;
}
+(NSString*)getOrderNumber
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *s = [dateFormatter stringFromDate:date];
    int number = (int)(0 + (arc4random() % (99999 - 0 + 1)));
    NSString *str = [NSString stringWithFormat:@"XS_%@%d",s,number];
    return str;
}
+(NSString *)getUserCustomerId
{
    NSDictionary *dict = [HelpClass getUserDict];
    return dict[@"Rows"][0][@"CustomerId"];
}
+(NSString *)getUserId
{
    NSDictionary *dict = [HelpClass getUserDict];
    return dict[@"Rows"][0][@"Id"];
}
+(NSString *)getAccessToken
{
    NSDictionary *dict = [HelpClass getUserDict];
    return dict[@"AccessToken"];
}
+(NSDictionary*)getUserDict
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:@"userInfoDict"];
}


//获取手机电话号码
+(NSString *)myNumber
{
    return CTSettingCopyMyPhoneNumber();
}
//判断手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber
{
    NSString*pattern =@"^1+[3578]+\\d{9}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    return [pred evaluateWithObject:telNumber];
}

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

////时间转换成几小时前
//+ (NSString *) compareCurrentTime:(NSString *)str
//{
//    
//    //把字符串转为NSdate
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//    NSDate *timeDate = [dateFormatter dateFromString:str];
//    
//    //得到与当前时间差
//    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
//    timeInterval = - timeInterval;
//    //标准时间和北京时间差8个小时
//    //    timeInterval = timeInterval - 8*60*60;
//    long temp = 0;
//    NSString *result;
//    if (timeInterval < 60) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分钟前",temp];
//    }
//    
//    else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//    }
//    
//    else if((temp = temp/24) <30){
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//    }
//    
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
//    
//    return  result;
//}

+(void)warning:(NSString*)text andView:(UIView*)view andHideTime:(double)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = text;
    [hud hide:YES afterDelay:time];
}


@end
