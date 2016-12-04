//
//  FavoriteXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/3.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FavoriteXMLModel.h"

@implementation FavoriteXMLModel
- (instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        self.type = [[[xml firstChildWithTag:@"type"]numberValue]intValue];
        self.title = [[xml firstChildWithTag:@"title"]stringValue];
        self.objid = [[[xml firstChildWithTag:@"objid"]numberValue]intValue];
        self.url = [[xml firstChildWithTag:@"url"]stringValue];
    }
    return self;
}
@end
