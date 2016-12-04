//
//  NetWorkHelp.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager+Util.h"
#import "AFOnoResponseSerializer.h"

typedef void(^SuccessBlock)(id obj);
typedef void(^FailBlock)(NSString *error);

typedef enum : NSUInteger {
    LoginModel,// 登录
    UserInfoModel,// 用户
    OtherUserModel,// 其他用户
    ActiveModel,// 动态
    FavoriteModel,// 收藏
    FriendModel,// 关注，粉丝
    MessageModel,// 私信
    BlogsModel,// 博客
    UpdateRelationModel,// 关注
} XMLModelType;

@interface NetWorkHelp : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (instancetype)shareHelper;
// 获取登录用户的信息
- (void) asyncUserInfoFromServer;
- (void) asyncDataFromServerWithParamDictionary:(NSDictionary *)paramDic andModelType:(XMLModelType)modelType andSuccessHandle:(SuccessBlock)successHandle andFailhandle:(FailBlock)failhandle;
- (void) asyncDataFromServerWithURLString:(NSString *)urlString andParamDictionary:(NSDictionary *)paramDic andModelType:(XMLModelType)modelType andSuccessHandle:(SuccessBlock)successHandle andFailhandle:(FailBlock)failhandle;
/**
 *  上传头像和反馈信息
 *
 *  @param image   图片
 *  @param message 反馈信息（当为nil时，表示上传头像，否则表示上传反馈信息）
 */
- (void)sendDataWithImage:(UIImage *)image andMessage:(NSString *)message andType:(int)type andSuccessHandle:(SuccessBlock)successHandle andFailhandle:(FailBlock)failhandle;;
@end
