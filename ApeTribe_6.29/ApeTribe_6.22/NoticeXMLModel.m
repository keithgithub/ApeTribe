//
//  NoticeXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "NoticeXMLModel.h"

@implementation NoticeXMLModel
- (instancetype) initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        self.atmeCount = [[[xml firstChildWithTag:@"atmeCount"]numberValue]intValue];
        self.msgCount = [[[xml firstChildWithTag:@"msgCount"]numberValue]intValue];
        self.reviewCount = [[[xml firstChildWithTag:@"reviewCount"]numberValue]intValue];
        self.newFansCount = [[[xml firstChildWithTag:@"newFansCount"]numberValue]intValue];
        self.newLikeCount = [[[xml firstChildWithTag:@"newLikeCount"]numberValue]intValue];
    }
    return self;
}
@end
