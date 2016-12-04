//
//  BlogXMLModelMine.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/4.
//  Copyright © 2016年 One. All rights reserved.
//

#import "BlogXMLModelMine.h"

@implementation BlogXMLModelMine
- (instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        
        self.blogId = [[[xml firstChildWithTag:@"id"]numberValue]longValue];
        self.authorname = [[xml firstChildWithTag:@"authorname"]stringValue];
        self.title = [[xml firstChildWithTag:@"title"]stringValue];
        self.pubDate = [[xml firstChildWithTag:@"pubDate"]stringValue];
        self.authorid = [[[xml firstChildWithTag:@"authorid"]numberValue]longValue];
        self.commentCount = [[[xml firstChildWithTag:@"commentCount"]numberValue]intValue];
        self.type = [[[xml firstChildWithTag:@"type"]numberValue]longValue];
        NSLog(@"blogId = %ld\nauthor = %@\ntitle = %@",self.blogId,self.authorname,self.title);
        
    }
    return self;
}


@end
