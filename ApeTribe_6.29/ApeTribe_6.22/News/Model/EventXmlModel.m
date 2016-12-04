//
//  EventXmlModel.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "EventXmlModel.h"

@implementation EventXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.eventId =[[[xml  firstChildWithTag:@"id"]numberValue] longValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.url = [[xml firstChildWithTag:@"url"] stringValue];
        self.cover =[[xml  firstChildWithTag:@"cover"]stringValue];
        self.status =[[[xml firstChildWithTag:@"status"] numberValue] longValue];
        self.applyStatus =[[[xml firstChildWithTag:@"applyStatus"] numberValue] longValue];

        self.startTime=[[xml  firstChildWithTag:@"startTime"]stringValue];
        self.endTime =[[xml  firstChildWithTag:@"endTime"] stringValue];
        self.createTime =[[xml  firstChildWithTag:@"createTime"] stringValue];
        self.spot=[[xml  firstChildWithTag:@"spot"]stringValue];
        self.city =[[xml  firstChildWithTag:@"city"] stringValue];
        
        self.body=[[xml  firstChildWithTag:@"body"]stringValue];
        self.actor_count=[[[xml  firstChildWithTag:@"actor_count"] numberValue] longValue];
        self.category = [[[xml firstChildWithTag:@"category"] numberValue] longValue];
    }
    return self;
}


+ (instancetype)eventXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}

@end
