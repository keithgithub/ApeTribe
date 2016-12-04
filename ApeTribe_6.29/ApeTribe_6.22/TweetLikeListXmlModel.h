//
//  TweetLikeListXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface TweetLikeListXmlModel : NSObject

//头像
@property(nonatomic,copy)NSString * portrait;
//昵称
@property(nonatomic,copy)NSString * name;


-(instancetype)initWithXML:(ONOXMLElement *)xml;


+(instancetype)tweetLikeListXmlModelWithXml:(ONOXMLElement *)xml;


@end
