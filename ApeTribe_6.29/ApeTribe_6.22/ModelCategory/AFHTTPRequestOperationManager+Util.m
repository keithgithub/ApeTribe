//
//  AFHTTPRequestOperationManager+Util.m
//  XMLForOSC_6_23_2
//
//  Created by guan song on 16/6/23.
//  Copyright © 2016年 hexiulian. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Util.h"
#import "AFOnoResponseSerializer.h"
@implementation AFHTTPSessionManager (Util)
+(instancetype)shareRequestManager
{
    //请求操作管理对象
    AFHTTPSessionManager *manager =[AFHTTPSessionManager  manager];
    //响应数据的格式xml(返回）
    manager.responseSerializer = [AFOnoResponseSerializer  XMLResponseSerializer];
    //接收参数类型(文本格式）
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes  setByAddingObject:@"text/html"];
    
    //设置请求头，服务器需要采集的数据
    [manager.requestSerializer  setValue:[self  generateUserAgent] forHTTPHeaderField:@"User-Agent"];
    
    return manager;
    
}
/**
 *  用户信息
 *
 *  @return 
 */
+(NSString *)generateUserAgent
{
    //从info.plist获取应用版本
    NSString *appVersion =[[NSBundle  mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    //设备的UUICD
    NSString *uuid = [[[UIDevice  currentDevice] identifierForVendor] UUIDString];
    //设备系统名
    NSString *dName =[UIDevice  currentDevice].systemName;
    NSString *dVersion =[UIDevice  currentDevice].systemVersion;
    //类型
    NSString *model =[UIDevice currentDevice].model;
    
    return [NSString stringWithFormat:@"%@/%@/%@/%@/%@",appVersion,uuid,dName,dVersion,model];
    
    
}
     
     
     
@end








