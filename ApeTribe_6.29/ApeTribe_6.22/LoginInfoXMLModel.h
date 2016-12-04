//
//  LoginInfoXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"


@interface LoginInfoXMLModel : NSObject

@property (nonatomic, copy)NSString *userId;// 用户id
@property (nonatomic, copy)NSString *name;// 用户名
@property (nonatomic, copy)NSString *avatar;// 用户头像地址
@property (nonatomic, copy)NSString *email;// 用户邮箱
@property (nonatomic, copy)NSString *gender;// (男：male，女：female，其他则为未填写)
@property (nonatomic, copy)NSString *location;// 用户所在地
@property (nonatomic, copy)NSString *url;// 用户主页url




- (instancetype)initWithXML:(ONOXMLElement *)xml;


@end
