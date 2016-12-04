//
//  DetailXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import "DetailXMLModel.h"

@implementation DetailXMLModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.strID = [[[xml  firstChildWithTag:@"id"] numberValue]longLongValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.url = [[xml  firstChildWithTag:@"url"] stringValue];
        self.extensionTitle = [[xml  firstChildWithTag:@"extensionTitle"] stringValue];
        self.authorid = [[xml  firstChildWithTag:@"authorid"] stringValue];
        self.license = [[xml  firstChildWithTag:@"license"] stringValue];
        self.body = [[xml  firstChildWithTag:@"body"] stringValue];
        self.homepage = [[xml  firstChildWithTag:@"homepage"] stringValue];
        self.document = [[xml  firstChildWithTag:@"document"] stringValue];
        self.download = [[xml  firstChildWithTag:@"download"] stringValue];
        self.language = [[xml  firstChildWithTag:@"language"] stringValue];
        self.os = [[xml  firstChildWithTag:@"os"] stringValue];
        self.logo = [[xml  firstChildWithTag:@"logo"] stringValue];
        self.recordtime = [[xml  firstChildWithTag:@"recordtime"] stringValue];
        self.recommended =[[[xml firstChildWithTag:@"recommended"] numberValue] longValue];
        self.favorite =[[[xml firstChildWithTag:@"favorite"] numberValue] longValue];
        self.tweetCount =[[[xml firstChildWithTag:@"tweetCount"] numberValue] longValue];
        
    }
    return self;
}

@end
