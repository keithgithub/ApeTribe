//
//  BloggerXmlModel.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "BloggerXmlModel.h"

@implementation BloggerXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.bloggerId =[[[xml  firstChildWithTag:@"id"]numberValue] longValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.body =[[xml  firstChildWithTag:@"body"]stringValue];
        self.commentCount =[[[xml firstChildWithTag:@"commentCount"] numberValue] longValue];
        self.authorname=[[xml  firstChildWithTag:@"authorname"]stringValue];
        self.authoruid =[[[xml  firstChildWithTag:@"authoruid"]numberValue ] longValue];
        self.pubDate =[[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.documentType =[[[xml firstChildWithTag:@"documentType"] numberValue] longValue];
        self.url = [[xml firstChildWithTag:@"url"] stringValue];
        self.type = 0;//最热

    }
    return self;
}


+ (instancetype)bloggerXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}
@end
