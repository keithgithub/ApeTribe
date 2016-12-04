//
//  LoginInfoXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import "LoginInfoXMLModel.h"

@implementation LoginInfoXMLModel



-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.userId =[[xml  firstChildWithTag:@"id"]stringValue];
        self.name =[[xml  firstChildWithTag:@"name"]stringValue];
        self.avatar =[[xml firstChildWithTag:@"avatar"] stringValue];
        self.email = [[xml  firstChildWithTag:@"email"]stringValue];
        self.gender =[[xml firstChildWithTag:@"gender"] stringValue];
        self.location = [[xml  firstChildWithTag:@"location"]stringValue];
        self.url = [[xml  firstChildWithTag:@"url"] stringValue];
        
    }
    return self;
}

@end
