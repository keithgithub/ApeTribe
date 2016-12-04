//
//  TweetCommentXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface TweetCommentXmlModel : NSObject


//评论ID
@property(nonatomic,assign)int tweetCommentID;
//评论头像地址
@property(nonatomic,copy)NSString * portrait;
//评论人昵称
@property(nonatomic,copy)NSString * author;
//评论评论人社区ID
@property(nonatomic,assign)long authorID;
//评论内容
@property(nonatomic,copy)NSString * content;
//评论的发布时间
@property(nonatomic,copy)NSString * pubDate;
//评论来源的客户端类型
@property(nonatomic,assign)int appclient;
//评论的回复列表
@property(nonatomic,copy)NSString * replies;
//评论的引用列表
@property(nonatomic,copy)NSString * refers;


-(instancetype)initWithXML:(ONOXMLElement *)xml;

+(instancetype)tweetCommentXmlModelWithXml:(ONOXMLElement *)xml;


@end
