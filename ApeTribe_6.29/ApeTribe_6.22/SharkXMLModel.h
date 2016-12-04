//
//  SharkXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface SharkXMLModel : NSObject
@property(nonatomic,copy)NSString *strID;//实体对应的id
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *url;//链接地址
@property(nonatomic,copy)NSString *author;//作者的昵称
@property(nonatomic,copy)NSString *image;//图片链接地址
@property(nonatomic,copy)NSString *detail;// 简短描述
@property(nonatomic,copy)NSString *time;// 时间

@property(nonatomic,assign)long randomtype;//要到的类型1 资讯2 软件3 博客
@property(nonatomic,assign)long commentCount;//软件的评论数量，即是跟软件相关的动弹
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
