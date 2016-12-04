//
//  EventDetailXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import "EventDetailXmlModel.h"

@implementation EventDetailXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        ONOXMLElement *objXml = [xml firstChildWithTag:@"event"];
        self.eventId =[[[objXml  firstChildWithTag:@"id"]numberValue] longValue];
        self.title = [[objXml  firstChildWithTag:@"title"] stringValue];
        self.url = [[objXml firstChildWithTag:@"url"] stringValue];
        self.cover =[[objXml  firstChildWithTag:@"cover"]stringValue];
        self.status =[[[objXml firstChildWithTag:@"status"] numberValue] longValue];
        self.applyStatus =[[[objXml firstChildWithTag:@"applyStatus"] numberValue] longValue];
        
        self.startTime=[[objXml  firstChildWithTag:@"startTime"]stringValue];
        self.endTime =[[objXml  firstChildWithTag:@"endTime"] stringValue];
        self.createTime =[[objXml  firstChildWithTag:@"createTime"] stringValue];
        self.spot=[[objXml  firstChildWithTag:@"spot"]stringValue];
        self.city =[[objXml  firstChildWithTag:@"city"] stringValue];
        
        self.body=[[xml  firstChildWithTag:@"body"]stringValue];
        self.actor_count=[[[objXml  firstChildWithTag:@"actor_count"] numberValue] longValue];
        self.category = [[[objXml firstChildWithTag:@"category"] numberValue] longValue];
        self.answerCount = [[[xml firstChildWithTag:@"answerCount"] numberValue] longValue];
        self.viewCount = [[[xml firstChildWithTag:@"viewCount"] numberValue] longValue];
        self.favorite = [[[xml firstChildWithTag:@"favorite"] numberValue] longValue];

    }
    return self;
}


+ (instancetype)eventDetailXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}
@end
