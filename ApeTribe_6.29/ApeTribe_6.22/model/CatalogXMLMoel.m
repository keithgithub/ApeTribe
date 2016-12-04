//
//  CatalogXMLMoel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "CatalogXMLMoel.h"

@implementation CatalogXMLMoel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
         self.name = [[xml  firstChildWithTag:@"name"] stringValue];
         self.cTag =[[[xml firstChildWithTag:@"tag"] numberValue] longValue];
        
    }
    return self;
}

@end
