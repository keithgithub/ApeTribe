//
//  SearchXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SearchXMLModel.h"

@implementation SearchXMLModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.softid = [[[xml  firstChildWithTag:@"id"] numberValue]longLongValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.name = [[xml  firstChildWithTag:@"name"] stringValue];
        self.author = [[xml  firstChildWithTag:@"author"] stringValue];
        self.url = [[xml  firstChildWithTag:@"url"] stringValue];
        self.type = [[xml  firstChildWithTag:@"type"] stringValue];
        self.pubDate = [[xml  firstChildWithTag:@"pubDate"] stringValue];
  
        
    }
    return self;
}

@end
