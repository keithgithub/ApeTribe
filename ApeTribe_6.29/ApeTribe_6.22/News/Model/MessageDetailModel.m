//
//  MessageDetailModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MessageDetailModel.h"

@implementation MessageDetailModel
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
        self.favorite =[[[xml  firstChildWithTag:@"favorite"]numberValue ] longValue];
        self.pubDate =[[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.url = [[xml firstChildWithTag:@"url"] stringValue];
        self.softwarelink=[[xml  firstChildWithTag:@"softwarelink"]stringValue];
        self.softwarename=[[xml  firstChildWithTag:@"softwarename"]stringValue];
        
        self.relativies = [NSMutableArray new];
    }
    return self;
}


+ (instancetype)messageDetailXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}

@end
