//
//  EventXmlModel.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface EventXmlModel : NSObject
@property(nonatomic,assign)long eventId;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *spot;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,assign)long status;
@property(nonatomic,assign)long applyStatus;
@property(nonatomic,assign)long category;
@property(nonatomic,strong)NSString *body;
@property(nonatomic,assign)long actor_count;
- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)eventXmlModelWithXml:(ONOXMLElement *)xml;
@end
