//
//  ActiveXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/4.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface ActiveXMLModel : NSObject
@property (nonatomic, assign) int activeId;// 动态id
@property (nonatomic, copy) NSString *portrait;// 发布动态者用户头像
@property (nonatomic, copy) NSString *author;// 发布者
@property (nonatomic, assign) long authorid;// 发布者id
@property (nonatomic, assign) int catalog;// 动态分类：1-新闻、2-问答区（发布帖子、回复帖子）、3-动弹、4-博客（发博客，评论）、0-其它
@property (nonatomic, assign) int appclient;// 客户端类型：1-WEB、2-WAP、3-Android、4-IOS、5-WP
@property (nonatomic, assign) long objectID;// 动态对象id：动弹 帖子 博客ID (根据objectType区分)
@property (nonatomic, assign) int objecttype;// 动态类型：1-开源软件、2-帖子、3-博客、4-新闻、5-代码、6-职位、7-翻译文章、8-翻译段落、16-新闻评论、17-讨论区答案、18-博客评论、19-代码评论、20-职位评论、21-翻译评论、32-职位评论、100-动弹、101-动弹回复
@property (nonatomic, assign) int objectcatalog;// 动态对象分类：1-普通帖子（问答），2-城市圈活动，3-城市圈讨论，4-话题，5-对帖子评论的回复
@property (nonatomic, copy) NSString *objecttitle;// 动态对象标题(动弹为空 帖子,博客的标题)
@property (nonatomic, copy) NSString *objectname;// 动态对象回复者昵称
@property (nonatomic, copy) NSString *objectbody;// 动态对象回复内容
@property (nonatomic, copy) NSString *url;// 动态对象链接
@property (nonatomic, copy) NSString *message;// 动态对象内容
@property (nonatomic, copy) NSString *tweetimage;// 动弹图片，catalog 为 3 时（即为动弹时）才可能存在
@property (nonatomic, assign) int commentCount;// 评论数
@property (nonatomic, copy) NSString *pubDate;// 发布时间
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
