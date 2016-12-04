//
//  NetWorkHelp.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "NetWorkHelp.h"
#import "FriendXMLModel.h"
#import "FavoriteXMLModel.h"
#import "NoticeXMLModel.h"
#import "UserInfoXMLModel.h"
#import "ActiveXMLModel.h"
#import "MsgXMLModelMine.h"
#import "BlogsXMLModelMine.h"
#import "BlogXMLModelMine.h"
#import "OtherUserXMLModel.h"
#import "ErrorMessageXMLModel.h"
@implementation NetWorkHelp


static NetWorkHelp *helper = nil;
+ (instancetype)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[NetWorkHelp alloc] init];
    });
    return helper;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initHelper];
    }
    return self;
}

- (void)initHelper
{
    _manager = [AFHTTPSessionManager shareRequestManager];
    
}
- (void) asyncUserInfoFromServer
{
    [Tool showNetWorkState];
    if (ACCESS_TOKEN == nil)
    {
        // 发送未登录通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    else
    {
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *access_token = ACCESS_TOKEN;
            NSLog(@"strURL = %@",access_token);
            // 请求
            [weakself.manager POST:URL_STR(SERVER, URL_USERINFO_LIST) parameters:PARAM_USERINFO_LIST(ACCESS_TOKEN, @"xml") progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ONOXMLDocument *docu = responseObject;
                ONOXMLElement *root = docu.rootElement;
                NSLog(@"responseObject ============ %@",responseObject);
                NSLog(@"root ============ %@",root);
                
                
                ONOXMLElement *userInfoXMLElement = [root firstChildWithTag:@"user"];
                UserInfoXMLModel *userModel = [[UserInfoXMLModel alloc]initWithXML:userInfoXMLElement];
                NSLog(@"userId = %@\nurl = %@",userModel.name,userModel.portrait);
                [[NSNotificationCenter defaultCenter] postNotificationName:FINISH_LOAD_DATA object:@YES];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [Tool writeLoginState:@"0" andKey:LOGIN_STATE];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                NSLog(@"用户下载失败");
            }];
            
//            [weakself.manager POST:URL_STR(SERVER, URL_USERINFO_LIST) parameters:PARAM_USERINFO_LIST(ACCESS_TOKEN, @"xml") success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//                
//                
//                
//            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//                
//            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });

    }
}

- (void) asyncDataFromServerWithParamDictionary:(NSDictionary *)paramDic andModelType:(XMLModelType)modelType andSuccessHandle:(SuccessBlock)successHandle andFailhandle:(FailBlock)failhandle
{
    [Tool showNetWorkState];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *strURL = strURL = URL_STR(SERVER, URL_USERINFO_LIST);;
        
        switch (modelType) {
            case LoginModel:
            {
                
                strURL = URL_STR(SERVER, URL_LOGIN_LIST);
//                paramDic = PARAM_LOGIN_LIST(ACCESS_TOKEN, @"xml");
            }
                
                break;
            case UserInfoModel:
            {
                
                strURL = URL_STR(SERVER, URL_USERINFO_LIST);
//                paramDic = PARAM_USERINFO_LIST(ACCESS_TOKEN, @"xml");
            }
                
                break;
            case OtherUserModel:
            {
                strURL = URL_STR(SERVER, URL_USER_LIST);
            }
                break;
            case FavoriteModel:
            {
                strURL = URL_STR(SERVER, URL_FAVORITE_LIST);
                
            }
                break;
            case FriendModel:
            {
                strURL = URL_STR(SERVER, URL_FRIEND_LIST);
//                paramDic = PARAM_FRIEND_LIST(1, 20, 0, ACCESS_TOKEN, @"xml");
            }
                break;
            default:
                NSLog(@"数据类型输入错误");
                return;
                break;
        }
        
        NSString *access_token = ACCESS_TOKEN;
        NSLog(@"strURL = %@",access_token);
        // 请求
        [weakself.manager POST:strURL parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 数据类型装换
            NSLog(@"%@",strURL);
            id obj;
            ONOXMLDocument *docu = responseObject;
            ONOXMLElement *root = docu.rootElement;
            NSLog(@"responseObject ============ %@",responseObject);
            NSLog(@"root ============ %@",root);
            switch (modelType) {
                case LoginModel:
                {
                    ONOXMLElement *loginXMLElement = [root firstChildWithTag:@"user"];
                    LoginInfoXMLModel *loginModel = [[LoginInfoXMLModel alloc]initWithXML:loginXMLElement];
                    NSLog(@"userId = %@\nurl = %@",loginModel.userId,loginModel.url);
                    obj = loginModel;
                }
                    break;
                case UserInfoModel:
                {
                    ONOXMLElement *userInfoXMLElement = [root firstChildWithTag:@"user"];
                    UserInfoXMLModel *userModel = [[UserInfoXMLModel alloc]initWithXML:userInfoXMLElement];
                    NSLog(@"userId = %@\nurl = %@",userModel.name,userModel.portrait);
                    obj = userModel;
                }
                    break;
                    
                case FavoriteModel:
                {
                    ONOXMLElement *favoriteXMLElement = [root firstChildWithTag:@"favorites"];
                    NSArray *arrFavorites = [favoriteXMLElement childrenWithTag:@"favorite"];
                    NSMutableArray *arrData = [NSMutableArray new];
                    for (ONOXMLElement *element in arrFavorites) {
                        FavoriteXMLModel *favoriteModel = [[FavoriteXMLModel alloc]initWithXML:element];
                        [arrData addObject:favoriteModel];
                        NSLog(@"title = %@\nurl = %@",favoriteModel.title,favoriteModel.url);
                    }
                    
                    obj = arrData;
                }
                    break;
                case OtherUserModel:
                {
                    ONOXMLElement *userXMLElement = [root firstChildWithTag:@"user"];
                    OtherUserXMLModel *otherModel = [[OtherUserXMLModel alloc]initWithXML:userXMLElement];
                    obj = otherModel;
                }
                    break;
                case FriendModel:
                {
                    ONOXMLElement *friendXMLElement = [root firstChildWithTag:@"friends"];
                    NSArray *arrfriends = [friendXMLElement childrenWithTag:@"friend"];
                    NSMutableArray *arrData = [NSMutableArray new];
                    for (ONOXMLElement *element in arrfriends) {
                        FriendXMLModel *friendModel = [[FriendXMLModel alloc]initWithXML:element];
                        [arrData addObject:friendModel];
                        NSLog(@"title = %@\nexpertise = %@",friendModel.name,friendModel.expertise);
                    }
                    
                    obj = arrData;
                }
                    break;
                default:
                    break;
            }
            
            
            successHandle(obj);
            

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failhandle(@"网络连接失败");
        }];
//        [weakself.manager POST:strURL parameters:paramDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            // 数据类型装换
//            NSLog(@"%@",strURL);
//            id obj;
//            ONOXMLDocument *docu = responseObject;
//            ONOXMLElement *root = docu.rootElement;
//            NSLog(@"responseObject ============ %@",responseObject);
//            NSLog(@"root ============ %@",root);
//            switch (modelType) {
//                case LoginModel:
//                {
//                    ONOXMLElement *loginXMLElement = [root firstChildWithTag:@"user"];
//                    LoginInfoXMLModel *loginModel = [[LoginInfoXMLModel alloc]initWithXML:loginXMLElement];
//                    NSLog(@"userId = %@\nurl = %@",loginModel.userId,loginModel.url);
//                    obj = loginModel;
//                }
//                    break;
//                case UserInfoModel:
//                {
//                    ONOXMLElement *userInfoXMLElement = [root firstChildWithTag:@"user"];
//                    UserInfoXMLModel *userModel = [[UserInfoXMLModel alloc]initWithXML:userInfoXMLElement];
//                    NSLog(@"userId = %@\nurl = %@",userModel.name,userModel.portrait);
//                    obj = userModel;
//                }
//                    break;
//                  
//                case FavoriteModel:
//                {
//                    ONOXMLElement *favoriteXMLElement = [root firstChildWithTag:@"favorites"];
//                    NSArray *arrFavorites = [favoriteXMLElement childrenWithTag:@"favorite"];
//                    NSMutableArray *arrData = [NSMutableArray new];
//                    for (ONOXMLElement *element in arrFavorites) {
//                        FavoriteXMLModel *favoriteModel = [[FavoriteXMLModel alloc]initWithXML:element];
//                        [arrData addObject:favoriteModel];
//                        NSLog(@"title = %@\nurl = %@",favoriteModel.title,favoriteModel.url);
//                    }
//                    
//                    obj = arrData;
//                }
//                    break;
//                case OtherUserModel:
//                {
//                    ONOXMLElement *userXMLElement = [root firstChildWithTag:@"user"];
//                    OtherUserXMLModel *otherModel = [[OtherUserXMLModel alloc]initWithXML:userXMLElement];
//                    obj = otherModel;
//                }
//                    break;
//                case FriendModel:
//                {
//                    ONOXMLElement *friendXMLElement = [root firstChildWithTag:@"friends"];
//                    NSArray *arrfriends = [friendXMLElement childrenWithTag:@"friend"];
//                    NSMutableArray *arrData = [NSMutableArray new];
//                    for (ONOXMLElement *element in arrfriends) {
//                        FriendXMLModel *friendModel = [[FriendXMLModel alloc]initWithXML:element];
//                        [arrData addObject:friendModel];
//                        NSLog(@"title = %@\nexpertise = %@",friendModel.name,friendModel.expertise);
//                    }
//                    
//                    obj = arrData;
//                }
//                    break;
//                default:
//                    break;
//            }
//            
//            
//            successHandle(obj);
//            
//            
//            
//        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//            failhandle(@"网络连接失败");
//        }];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
    });
    
}

- (void) asyncDataFromServerWithURLString:(NSString *)urlString andParamDictionary:(NSDictionary *)paramDic andModelType:(XMLModelType)modelType andSuccessHandle:(SuccessBlock)successHandle andFailhandle:(FailBlock)failhandle{
    // 数据类型装换
    NSLog(@"urlString == %@",urlString);
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakself.manager POST:urlString parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id obj;
            ONOXMLDocument *docu = responseObject;
            ONOXMLElement *root = docu.rootElement;
            NSLog(@"docu == %@",docu);
            NSLog(@"root == %@",root);
            switch (modelType) {
                case ActiveModel:
                {
                    ONOXMLElement *activeXMLElement = [root firstChildWithTag:@"activies"];
                    NSArray *arrActives = [activeXMLElement childrenWithTag:@"active"];
                    NSMutableArray *arrData = [NSMutableArray new];
                    for (ONOXMLElement *element in arrActives) {
                        ActiveXMLModel *activeModel = [[ActiveXMLModel alloc]initWithXML:element];
                        [arrData addObject:activeModel];
                        NSLog(@"portrait = %@\nauthor = %@",activeModel.portrait,activeModel.author);
                    }
                    obj = arrData;
                    
                }
                    break;
                case MessageModel:
                {
                    ONOXMLElement *messageXMLElement = [root firstChildWithTag:@"messages"];
                    NSArray *arrMessages = [messageXMLElement childrenWithTag:@"message"];
                    NSMutableArray *arrData = [NSMutableArray new];
                    for (ONOXMLElement *element in arrMessages)
                    {
                        MsgXMLModelMine *messageModel = [[MsgXMLModelMine alloc]initWithXML:element];
                        [arrData addObject:messageModel];
                        NSLog(@"sendername = %@\ncontent = %@",messageModel.sendername,messageModel.content);
                    }
                    obj = arrData;
                }
                    break;
                case BlogsModel:
                {
                    
                    BlogsXMLModelMine *blogs = [[BlogsXMLModelMine alloc]initWithXML:root];
                    
                    obj = blogs;
                }
                    break;
                    
                case UpdateRelationModel:
                {
                    ONOXMLElement *xml = [root firstChildWithTag:@"result"];
                    ErrorMessageXMLModel *errorModel = [[ErrorMessageXMLModel alloc]initWithXML:xml];
                    obj = errorModel;
                }
                    break;
                case FriendModel:
                {
                    ONOXMLElement *friendXMLElement = [root firstChildWithTag:@"friends"];
                    NSArray *arrfriends = [friendXMLElement childrenWithTag:@"friend"];
                    NSMutableArray *arrData = [NSMutableArray new];
                    for (ONOXMLElement *element in arrfriends) {
                        FriendXMLModel *friendModel = [[FriendXMLModel alloc]initWithXML:element];
                        [arrData addObject:friendModel];
                        NSLog(@"title = %@\nexpertise = %@",friendModel.name,friendModel.expertise);
                    }
                    
                    obj = arrData;
                }
                    break;
                default:
                    break;
            }
            successHandle(obj);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    });

    
    
}

#pragma mark - 发送头像或者反馈信息

- (void) sendDataWithImage:(UIImage *)image andMessage:(NSString *)message andType:(int)type andSuccessHandle:(SuccessBlock)successHandle andFailhandle:(FailBlock)failhandle
{

    NSDictionary *paramDic;
    NSString *strUrl;
    if (message == nil) {
        strUrl = URL_STR(SERVER, URL_PORTRAIT_UPDATE_LIST);
        paramDic = PARAM_PORTRAIT_UPDATE_LIST(ACCESS_TOKEN, @"xml");
    }
    else
    {
        strUrl = [NSString stringWithFormat:@"%@%@",URL_HTTP_PREFIX,URL_FEEDBACK_LIST];
        paramDic = PARAM_FEEDBACK_LIST(2, type, message);
        
    }
    __weak typeof(self) weakself = self;
    // 异步线程网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakself.manager POST:strUrl parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (image != nil) {
                [formData appendPartWithFileData:[Tool compressImage:image]
                                            name:@"portrait"
                                        fileName:@"img.jpg"
                                        mimeType:@"image/jpeg"];
            }

        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //        NSLog(@"responseObject = %@",responseObject);
            ONOXMLDocument *docu = responseObject;
            ONOXMLElement *root = docu.rootElement;
            ONOXMLElement *errorXML = [root firstChildWithTag:@"result"];
            ErrorMessageXMLModel *errorModel = [[ErrorMessageXMLModel alloc]initWithXML:errorXML];
            //        NSLog(@"docu == %@",docu);
            //        NSLog(@"root == %@",root);
            // ch
            if (errorModel.errorCode == 200)
            {
                [[NetWorkHelp shareHelper]asyncUserInfoFromServer];
                successHandle(errorModel);
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络异常，发送失败");
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}








@end