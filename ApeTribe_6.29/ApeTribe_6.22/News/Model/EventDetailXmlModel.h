//
//  EventDetailXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface EventDetailXmlModel : NSObject
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
@property(nonatomic,assign)long answerCount;
@property(nonatomic,assign)long viewCount;
@property(nonatomic,assign)long favorite;



@property (nonatomic,strong) NSMutableArray *remark;
- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)eventDetailXmlModelWithXml:(ONOXMLElement *)xml;
@end
