//
//  MessageXmlModel.h
//  OpenSourceChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface MessageXmlModel : NSObject

@property(nonatomic,assign)long   newsId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,assign)long   commentCount;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,assign)long   authorid;
@property(nonatomic,assign)long   newstype;
@property(nonatomic,assign)long   authoruid2;
@property(nonatomic,strong)NSString *url;

- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)messageXmlModelWithXml:(ONOXMLElement *)xml;
@end
