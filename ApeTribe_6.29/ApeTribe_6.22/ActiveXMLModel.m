//
//  ActiveXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/4.
//  Copyright © 2016年 One. All rights reserved.
//

#import "ActiveXMLModel.h"

@implementation ActiveXMLModel
- (instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        self.activeId = [[[xml firstChildWithTag:@"id"]numberValue]intValue];
        self.portrait = [[xml firstChildWithTag:@"portrait"]stringValue];
        self.author = [[xml firstChildWithTag:@"author"]stringValue];
        self.authorid = [[[xml firstChildWithTag:@"authorid"]numberValue]longValue];
        self.catalog = [[[xml firstChildWithTag:@"catalog"]numberValue]intValue];
        self.appclient = [[[xml firstChildWithTag:@"appclient"]numberValue]intValue];
        self.objectID = [[[xml firstChildWithTag:@"objectID"]numberValue]longValue];
        self.objecttype = [[[xml firstChildWithTag:@"objecttype"]numberValue]intValue];
        self.objectcatalog = [[[xml firstChildWithTag:@"objectcatalog"]numberValue]intValue];
        self.objecttitle = [[xml firstChildWithTag:@"objecttitle"]stringValue];
        self.objectname = [[[xml firstChildWithTag:@"objectreply"]firstChildWithTag:@"objectname"]stringValue];
        self.objectbody = [[[xml firstChildWithTag:@"objectreply"]firstChildWithTag:@"objectbody"]stringValue];
        self.url = [[xml firstChildWithTag:@"url"]stringValue];
        self.message = [[xml firstChildWithTag:@"message"]stringValue];
        self.tweetimage = [[xml firstChildWithTag:@"tweetimage"]stringValue];
        self.commentCount = [[[xml firstChildWithTag:@"commentCount"]numberValue]intValue];
        self.pubDate = [[xml firstChildWithTag:@"pubDate"]stringValue];
    }
    return self;
}

@end
