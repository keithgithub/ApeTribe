//
//  FindXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FindXMLModel.h"

@implementation FindXMLModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.userid = [[[xml  firstChildWithTag:@"uid"] numberValue]longLongValue];
        self.name = [[xml  firstChildWithTag:@"name"] stringValue];
        self.portrait = [[xml  firstChildWithTag:@"portrait"] stringValue];
        self.gender = [[xml  firstChildWithTag:@"gender"] stringValue];
        self.from = [[xml  firstChildWithTag:@"from"] stringValue];
        
    }
    return self;
}

-(instancetype)initWithXML:(ONOXMLElement *)xml andBool:(BOOL)isSelect
{
    
    if (self =[super init])
    {
        self.userid = [[[xml  firstChildWithTag:@"uid"] numberValue]longLongValue];
        self.name = [[xml  firstChildWithTag:@"name"] stringValue];
        self.portrait = [[xml  firstChildWithTag:@"portrait"] stringValue];
        self.gender = [[xml  firstChildWithTag:@"gender"] stringValue];
        self.from = [[xml  firstChildWithTag:@"from"] stringValue];
        self.isSelect = isSelect;
    }
    return self;
    
    
    
}


@end
