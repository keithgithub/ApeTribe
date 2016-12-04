//
//  TweetDetailXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface TweetDetailXmlModel : NSObject

//漫谈的ID
@property(nonatomic,assign)int tweetDetailID;
//漫谈作者的头像地址
@property(nonatomic,copy)NSString * portrait;
//漫谈的作者昵称
@property(nonatomic,copy)NSString * author;
//漫谈作者的社区ID
@property(nonatomic,assign)long authorID;
//漫谈的内容
@property(nonatomic,copy)NSString * body;
//语音漫谈的地址
@property(nonatomic,copy)NSString * attach;
//漫谈来源客户端类型
@property(nonatomic,assign)int appclient;
//漫谈评论数量
@property(nonatomic,assign)int commentCount;
//漫谈发布日期
@property(nonatomic,copy)NSString * pubDate;
//漫谈图片缩略图地址
@property(nonatomic,copy)NSString * imgSmall;
//漫谈图片地址
@property(nonatomic,copy)NSString * imgBig;
//漫谈的点赞数量
@property(nonatomic,assign)int likeCount;
//是否已经对该漫谈点赞
@property(nonatomic,assign)int isLike;

//点赞列表
@property(nonatomic,strong)NSMutableArray * likeList;


-(instancetype)initWithXML:(ONOXMLElement *)xml;

+(instancetype)tweetDetailXmlModelWithXml:(ONOXMLElement *)xml;

@end
