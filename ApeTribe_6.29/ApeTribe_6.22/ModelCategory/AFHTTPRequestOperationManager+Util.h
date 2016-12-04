//
//  AFHTTPRequestOperationManager+Util.h
//  XMLForOSC_6_23_2
//
//  Created by guan song on 16/6/23.
//  Copyright © 2016年 hexiulian. All rights reserved.
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
