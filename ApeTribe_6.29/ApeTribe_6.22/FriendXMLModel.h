//
//  FriendXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/3.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface FriendXMLModel : NSObject
@property (nonatomic, assign)int userId;// 用户id
@property(nonatomic,copy)NSString *name;// 用户名
@property(nonatomic,copy)NSString *portrait;// 用户头像
@property(nonatomic,copy)NSString *expertise;// 专业技能
@property(nonatomic,assign)int   gender;// 性别

- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
