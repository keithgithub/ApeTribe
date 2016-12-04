//
//  MsgXMLModelMine.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/4.
//  Copyright © 2016年 One. All rights reserved.
//

#import "MsgXMLModelMine.h"

@implementation MsgXMLModelMine
- (instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        self.msgId = [[[xml firstChildWithTag:@"id"]numberValue]longValue];
        self.portrait = [[xml firstChildWithTag:@"portrait"]stringValue];
        self.friendid = [[[xml firstChildWithTag:@"friendid"]numberValue]longValue];
        self.friendname = [[xml firstChildWithTag:@"friendname"]stringValue];
        self.senderid = [[[xml firstChildWithTag:@"senderid"]numberValue]longValue];
        self.sendername = [[xml firstChildWithTag:@"sendername"]stringValue];
        self.content = [[xml firstChildWithTag:@"content"]stringValue];
        self.messageCount = [[[xml firstChildWithTag:@"messageCount"]numberValue]intValue];
        self.pubDate = [[xml firstChildWithTag:@"pubDate"]stringValue];
    }
    return self;
}

@end
