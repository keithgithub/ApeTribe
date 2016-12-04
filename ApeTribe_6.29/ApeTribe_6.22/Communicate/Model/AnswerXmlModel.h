//
//  AnswerXmlModel.h
//  OpenSourceChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface AnswerXmlModel : NSObject
@property(nonatomic,assign)long   answerId;
@property(nonatomic,assign)long   authorid;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,assign)long   answerCount;
@property(nonatomic,assign)long   viewCount;
@property(nonatomic,copy)NSString *pubDate;

- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)answerXmlModelWithXml:(ONOXMLElement *)xml;
@end
