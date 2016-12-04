//
//  SoftWareXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SoftWareXMLModel.h"

@implementation SoftWareXMLModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.softid = [[[xml  firstChildWithTag:@"id"] numberValue]longLongValue];
        self.authorid = [[[xml  firstChildWithTag:@"authorid"] numberValue]longLongValue];
        self.author = [[xml  firstChildWithTag:@"author"] stringValue];
        self.portrait = [[xml  firstChildWithTag:@"portrait"] stringValue];
        self.body = [[xml  firstChildWithTag:@"body"] stringValue];
        self.pubDate = [[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.appclient = [[[xml  firstChildWithTag:@"appclient"] numberValue]longLongValue];
        self.commentCount =[[[xml firstChildWithTag:@"commentCount"] numberValue] longValue];
                
    }
    return self;
}

@end
