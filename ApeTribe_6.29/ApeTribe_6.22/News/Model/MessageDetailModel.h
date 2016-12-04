//
//  MessageDetailModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface MessageDetailModel : NSObject
@property(nonatomic,assign)long   newsId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,assign)long   commentCount;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,assign)long   authorid;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,copy)NSString *softwarelink;
@property(nonatomic,copy)NSString *softwarename;
@property(nonatomic,assign)long   favorite;
@property (nonatomic,strong) NSMutableArray *relativies;

- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)messageDetailXmlModelWithXml:(ONOXMLElement *)xml;
@end
