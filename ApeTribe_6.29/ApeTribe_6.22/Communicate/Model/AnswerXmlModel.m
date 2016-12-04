//
//  AnswerXmlModel.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "AnswerXmlModel.h"

@implementation AnswerXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.answerId =[[[xml  firstChildWithTag:@"id"]numberValue] longValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.body =[[xml  firstChildWithTag:@"body"]stringValue];
        self.answerCount =[[[xml firstChildWithTag:@"answerCount"] numberValue] longValue];
        self.author=[[xml  firstChildWithTag:@"author"]stringValue];
        self.authorid =[[[xml  firstChildWithTag:@"authorid"]numberValue ] longValue];
        self.pubDate =[[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.viewCount =[[[xml firstChildWithTag:@"viewCount"] numberValue] longValue];
        self.portrait = [[xml firstChildWithTag:@"portrait"] stringValue];
        
    }
    return self;
}


+ (instancetype)answerXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}
@end
