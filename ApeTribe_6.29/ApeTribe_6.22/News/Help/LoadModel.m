//
//  LoadModel.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "LoadModel.h"
#import "Ono.h"
@implementation LoadModel
+(void)postRequestWithUrl:(NSString *)urlStr
                andParams:(NSDictionary *)paramsDict
              andSucBlock:(SuccessCallBack)sucCallBack
             andFailBlock:(FailCallBack)failCallBack
{
    //创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareRequestManager];
    [manager POST:urlStr parameters:paramsDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucCallBack)
        {
            sucCallBack(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failCallBack)
        {
            failCallBack(error);
        }
    }];

    
    
}


+(void)getRequestWithUrl:(NSString *)urlStr andSucBlock:(SuccessCallBack)sucCallBack andFailBlock:(FailCallBack)failCallBack
{
    //创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareRequestManager];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucCallBack)
        {
            sucCallBack(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failCallBack)
        {
            failCallBack(error);
        }
    }];

}
@end
