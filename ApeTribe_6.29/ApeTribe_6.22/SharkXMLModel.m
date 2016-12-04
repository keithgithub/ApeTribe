//
//  SharkXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SharkXMLModel.h"

@implementation SharkXMLModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.strID = [[xml  firstChildWithTag:@"id"] stringValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.url = [[xml  firstChildWithTag:@"url"] stringValue];
        self.author = [[xml  firstChildWithTag:@"author"] stringValue];
        self.detail = [[xml  firstChildWithTag:@"detail"] stringValue];
        self.image = [[xml  firstChildWithTag:@"image"] stringValue];
         self.time = [[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.commentCount =[[[xml firstChildWithTag:@"commentCount"] numberValue] longValue];
        self.randomtype =[[[xml firstChildWithTag:@"randomtype"] numberValue] longValue];
        
    }
    return self;
}

@end
