
//
//  OtherUserXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "OtherUserXMLModel.h"

@implementation OtherUserXMLModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.userId =[[[xml  firstChildWithTag:@"uid"]numberValue]longValue];
        self.latestLoginTime = [[xml firstChildWithTag:@"latestLoginTime"]stringValue];
        self.name =[[xml  firstChildWithTag:@"name"] stringValue];
        self.ident = [[xml firstChildWithTag:@"ident"] stringValue];
        self.portrait = [[xml  firstChildWithTag:@"portrait"] stringValue];
        self.joinTime =[[xml  firstChildWithTag:@"jointime"]stringValue];
        self.province =[[xml firstChildWithTag:@"province"] stringValue];
        self.city =[[xml firstChildWithTag:@"city"] stringValue];
        self.platforms =[[xml  firstChildWithTag:@"platforms"]stringValue];
        self.relation =[[[xml  firstChildWithTag:@"relation"]numberValue]intValue];
        self.expertise = [xml childrenWithTag:@"expertise"];
        self.gender =[[[xml  firstChildWithTag:@"gender"] numberValue]intValue];
        self.score =[[[xml  firstChildWithTag:@"score"]numberValue] longValue];
        self.favoriteCount =[[[xml  firstChildWithTag:@"favoriteCount"] numberValue] longValue];
        self.fans = [[[xml firstChildWithTag:@"fansCount"]numberValue]longValue];
        self.followers = [[[xml firstChildWithTag:@"followersCount"]numberValue]longValue];
        self.relation = [[[xml firstChildWithTag:@"relation"]numberValue]intValue];
        NSLog(@"relation = %d \nself.ident = %@\nself.latestLoginTime = %@ ",self.relation,self.ident,self.latestLoginTime);
        
    }
    return self;
}

@end
