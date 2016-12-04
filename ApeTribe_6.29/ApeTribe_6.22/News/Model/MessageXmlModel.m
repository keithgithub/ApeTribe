//
//  MessageXmlModel.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "MessageXmlModel.h"

@implementation MessageXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.newsId =[[[xml  firstChildWithTag:@"id"]numberValue] longValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.body =[[xml  firstChildWithTag:@"body"]stringValue];
        self.commentCount =[[[xml firstChildWithTag:@"commentCount"] numberValue] longValue];
        self.author=[[xml  firstChildWithTag:@"author"]stringValue];
        self.authorid =[[[xml  firstChildWithTag:@"aithorid"]numberValue ] longValue];
        self.pubDate =[[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.newstype =[[[[xml  firstChildWithTag:@"newstype"] firstChildWithTag:@"type"] numberValue] longValue];
        self.authoruid2 =[[[[xml  firstChildWithTag:@"newstype"] firstChildWithTag:@"authoruid2"] numberValue] longValue];
        self.url = [[xml firstChildWithTag:@"url"] stringValue];
    }
    return self;
}


+ (instancetype)messageXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}

@end
