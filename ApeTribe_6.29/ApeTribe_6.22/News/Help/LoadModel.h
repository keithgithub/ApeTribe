//
//  LoadModel.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessCallBack)(id responseObject);
//请求失败代码块
typedef void(^FailCallBack) (NSError *error);

@interface LoadModel : NSObject
/**
 *  网络post方式请求
 *
 *  @param urlStr       请求主链接
 *  @param paramsDict   链接参数body
 *  @param sucCallBack  请求成功回调代码块
 *  @param failCallBack 请求失败回调代码块
 */
+(void)postRequestWithUrl:(NSString *)urlStr
                andParams:(NSDictionary *)paramsDict
              andSucBlock:(SuccessCallBack)sucCallBack
             andFailBlock:(FailCallBack)failCallBack;
/**
 *  网络get方式请求
 *
 *  @param urlStr       请求主链接
 *  @param sucCallBack  请求成功回调代码块
 *  @param failCallBack 请求失败回调代码块
 */
+(void)getRequestWithUrl:(NSString *)urlStr
              andSucBlock:(SuccessCallBack)sucCallBack
             andFailBlock:(FailCallBack)failCallBack;
@end
