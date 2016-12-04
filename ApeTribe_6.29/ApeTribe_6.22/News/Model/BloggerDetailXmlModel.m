//
//  BloggerDetailXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import "BloggerDetailXmlModel.h"

@implementation BloggerDetailXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.bloggerId =[[[xml  firstChildWithTag:@"id"]numberValue] longValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.url = [[xml firstChildWithTag:@"url"] stringValue];

        self.body =[[xml  firstChildWithTag:@"body"]stringValue];
        self.commentCount =[[[xml firstChildWithTag:@"commentCount"] numberValue] longValue];
        self.author=[[xml  firstChildWithTag:@"author"]stringValue];
        self.authoruid =[[[xml  firstChildWithTag:@"authoruid"]numberValue ] longValue];
        self.pubDate =[[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.documentType =[[[xml firstChildWithTag:@"documentType"] numberValue] longValue];
        self.favorite =[[[xml firstChildWithTag:@"favorite"] numberValue] longValue];
        self.where = [[xml  firstChildWithTag:@"where"] stringValue];
    }
    return self;
}


+ (instancetype)bloggerDetailXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}
@end
