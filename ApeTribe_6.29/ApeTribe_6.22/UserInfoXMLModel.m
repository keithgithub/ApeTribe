//
//  UserInfoXMLModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 One. All rights reserved.
//

#import "UserInfoXMLModel.h"

@implementation UserInfoXMLModel

singleton_implementation(UserInfoXMLModel)

-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.userId =[[[xml  firstChildWithTag:@"uid"]numberValue]longValue];
        self.name =[[xml  firstChildWithTag:@"name"] stringValue];
        self.portrait = [[xml  firstChildWithTag:@"portrait"] stringValue];
        self.joinTime =[[xml  firstChildWithTag:@"jointime"]stringValue];
        self.province =[[xml firstChildWithTag:@"province"] stringValue];
        self.city =[[xml firstChildWithTag:@"city"] stringValue];
        self.platforms =[[xml  firstChildWithTag:@"platforms"]stringValue];
        self.expertise = [[xml firstChildWithTag:@"expertise"]stringValue];
        self.gender =[[[xml  firstChildWithTag:@"gender"] numberValue]longValue];
        self.score =[[[xml  firstChildWithTag:@"score"]numberValue] longValue];
        self.favoriteCount =[[[xml  firstChildWithTag:@"favoriteCount"] numberValue] longValue];
        self.fans = [[[xml firstChildWithTag:@"fansCount"]numberValue]longValue];
        self.followers = [[[xml firstChildWithTag:@"followersCount"]numberValue]longValue];
        self.email = [[xml firstChildWithTag:@"email"]stringValue];
//        NSLog(@"self.userId = %ld \nself.province = %@\nself.expertise[0] = %@ ",self.userId,self.province,self.expertise);
        self.url = [NSString stringWithFormat:@"http://my.oschina.net/u/%ld",self.userId];
//        NSLog(@"self.url === %@",self.url);
    }
    return self;
}

@end
