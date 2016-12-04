//
//  AFHTTPSessionManager+Util.h
//  YuanSheng
//
//  Created by ibokan on 16/7/28.
//  Copyright © 2016年 zhengshengxi. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (Util)

/**
 *  配置好的manager
 *
 *  @return manager对象
 */
+(instancetype)shareRequestManager;

@end
