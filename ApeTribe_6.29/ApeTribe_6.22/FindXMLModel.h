//
//  FindXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface FindXMLModel : NSObject
@property(nonatomic,assign)long userid;//用户id
@property(nonatomic,copy)NSString *name;//用户昵称
@property(nonatomic,copy)NSString *gender;//性别
@property(nonatomic,copy)NSString *portrait;//图片链接地址
@property(nonatomic,copy)NSString *from;// 所在地
@property(nonatomic,assign)BOOL isSelect;
- (instancetype)initWithXML:(ONOXMLElement *)xml;

- (instancetype)initWithXML:(ONOXMLElement *)xml andBool:(BOOL)isSelect;

@end
