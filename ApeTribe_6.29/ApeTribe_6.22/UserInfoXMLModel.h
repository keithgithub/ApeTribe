//
//  UserInfoXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface UserInfoXMLModel : NSObject

singleton_interface(UserInfoXMLModel)

@property (nonatomic, assign)long userId;// 用户id
@property(nonatomic,copy)NSString *name;// 用户名
@property(nonatomic,copy)NSString *portrait;// 用户头像
@property(nonatomic,copy)NSString *joinTime;// 注册时间
@property(nonatomic,copy)NSString *province;// 所在省
@property(nonatomic,copy)NSString *city;// 所在市
@property(nonatomic,copy)NSString *platforms;// 开发平台
@property(nonatomic,copy)NSString *expertise;// 专业技能
@property(nonatomic,copy)NSString *email;// 邮箱
@property(nonatomic,assign)long   gender;// 性别
@property(nonatomic,assign)long   score;// 社区积分
@property(nonatomic,assign)long   favoriteCount;// 收藏数量
@property(nonatomic,assign)long   fans;// 粉丝数量
@property(nonatomic,assign)long   followers;// 关注的用户数量
@property(nonatomic, copy) NSString *url;// 用户主页
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
