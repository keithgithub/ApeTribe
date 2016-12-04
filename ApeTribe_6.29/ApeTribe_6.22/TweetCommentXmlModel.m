//
//  TweetCommentXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TweetCommentXmlModel.h"

@implementation TweetCommentXmlModel


-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        //评论ID
        self.tweetCommentID = [[[xml firstChildWithTag:@"id"]numberValue]intValue];
        //评论人头像地址
        self.portrait = [[xml firstChildWithTag:@"portrait"]stringValue];
        //评论人昵称
        self.author = [[xml firstChildWithTag:@"author"]stringValue];
        //评论人社区ID
        self.authorID = [[[xml firstChildWithTag:@"authorid"]numberValue]longValue];
        //评论内容
        self.content = [[xml firstChildWithTag:@"content"]stringValue];
        //评论的发布时间
        self.pubDate = [[xml firstChildWithTag:@"pubDate"]stringValue];
        //评论来源的客户端类型
        self.appclient = [[[xml firstChildWithTag:@"appclient"]numberValue]intValue];
        //评论的回复列表
        self.replies = [[xml firstChildWithTag:@"replies"]stringValue];
        //评论的引用列表
        self.refers = [[xml firstChildWithTag:@"refers"]stringValue];
    }
    return self;
}


+(instancetype)tweetCommentXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}



@end
