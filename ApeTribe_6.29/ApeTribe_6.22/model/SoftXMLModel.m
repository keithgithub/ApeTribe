//
//  SoftXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SoftXMLModel.h"

@implementation SoftXMLModel

-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        self.name = [[xml firstChildWithTag:@"name"]stringValue];
        self.Adescription = [[xml firstChildWithTag:@"description"]stringValue];
        self.url = [[xml firstChildWithTag:@"url"]stringValue];
    }
    return self;
}
@end
