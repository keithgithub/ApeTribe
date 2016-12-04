//
//  TweetLikeListXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TweetLikeListXmlModel.h"

@implementation TweetLikeListXmlModel


-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if ([super init])
    {
        //头像
        self.portrait = [[xml firstChildWithTag:@"portrait"]stringValue];
        //昵称
        self.name = [[xml firstChildWithTag:@"name"]stringValue];
    }
    return self;
}


+(instancetype)tweetLikeListXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}



@end
