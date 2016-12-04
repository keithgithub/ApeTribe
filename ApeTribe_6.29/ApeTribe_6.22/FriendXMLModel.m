//
//  FriendXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/3.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FriendXMLModel.h"

@implementation FriendXMLModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.userId =[[[xml  firstChildWithTag:@"userid"]numberValue]intValue];
        self.name =[[xml  firstChildWithTag:@"name"] stringValue];
        self.portrait = [[xml  firstChildWithTag:@"portrait"] stringValue];
        //        self.expertise =[[xml  firstChildWithTag:@"expertise"]stringValue];
        self.expertise = [[xml firstChildWithCSS:@"expertise"]stringValue];
        self.gender =[[[xml  firstChildWithTag:@"gender"] numberValue]intValue];
        NSLog(@"self.userId = %d \nself.name = %@\nself.expertise = %@ ",self.userId,self.name,self.expertise);
        
    }
    return self;
}

@end
