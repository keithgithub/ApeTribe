//
//  OtherUserXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface OtherUserXMLModel : NSObject
@property (nonatomic, assign)long userId;// 用户id
@property(nonatomic,copy)NSString *ident;// 用户Ident
@property(nonatomic,copy)NSString *name;// 用户名
@property(nonatomic,copy)NSString *portrait;// 用户头像
@property(nonatomic,copy)NSString *joinTime;// 注册时间
@property (nonatomic, copy) NSString *latestLoginTime;// 最近登录时间
@property(nonatomic,copy)NSString *province;// 所在省
@property(nonatomic,copy)NSString *city;// 所在市
@property(nonatomic,copy)NSString *platforms;// 开发平台
@property(nonatomic,copy)NSArray *expertise;// 专业技能
@property(nonatomic,assign)int  relation;// 关注情况：1-已关注（对方未关注我）2-相互关注 3-未关注
@property(nonatomic,assign)int   gender;// 性别：1-男，2-女
@property(nonatomic,assign)long   score;// 社区积分
@property(nonatomic,assign)long   favoriteCount;// 收藏数量
@property(nonatomic,assign)long   fans;// 粉丝数量
@property(nonatomic,assign)long   followers;// 关注的用户数量
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
