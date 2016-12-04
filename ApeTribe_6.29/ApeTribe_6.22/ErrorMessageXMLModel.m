//
//  ErrorMessageXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "ErrorMessageXMLModel.h"

@implementation ErrorMessageXMLModel
- (instancetype) initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        self.errorCode = [[[xml firstChildWithTag:@"errorCode"]numberValue]longValue];
        self.errorMessage = [[xml firstChildWithTag:@"errorMessage"]stringValue];
        NSLog(@"self.errorCode = %ld\nself.errorMessage = %@",self.errorCode,self.errorMessage);
    }
    return self;
}
@end
