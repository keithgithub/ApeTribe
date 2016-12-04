//
//  DetailXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface DetailXMLModel : NSObject
@property(nonatomic,assign)long strID;//软件的id
@property(nonatomic,copy)NSString *title;//软件的标题
@property(nonatomic,copy)NSString *url;//软件的链接地址
@property(nonatomic,copy)NSString *extensionTitle;//软件的扩展标题
@property(nonatomic,copy)NSString *authorid;//软件作者的社区id
@property(nonatomic,copy)NSString *license;//软件的开源协议
@property(nonatomic,copy)NSString *body;// 软件的详情描述
@property(nonatomic,copy)NSString *homepage;//软件主页地址
@property(nonatomic,copy)NSString *document;//软件的文档地址
@property(nonatomic,copy)NSString *download;//软件的下载地址
@property(nonatomic,copy)NSString *logo;//软件的logo地址
@property(nonatomic,copy)NSString *language;//软件的开发语言
@property(nonatomic,copy)NSString *os;//软件支持的系统平台
@property(nonatomic,copy)NSString *recordtime;//软件的收录时间
@property(nonatomic,assign)long favorite;//是否已经收藏0 未收藏1 已收藏
@property(nonatomic,assign)long tweetCount;//软件的评论数量，即是跟软件相关的动弹
@property(nonatomic,assign)long recommended;//是否已经被推荐，4才表示该软件被推荐
- (instancetype)initWithXML:(ONOXMLElement *)xml;

@end
