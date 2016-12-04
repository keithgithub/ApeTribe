//
//  CommentXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface CommentXmlModel : NSObject

@property(nonatomic,assign)long   commentId;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,assign)long   authorid;
@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)long   appclient;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,strong) NSMutableArray *replies;
@property(nonatomic,strong) NSMutableArray *refers;

- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype) commmentXmlModelWithXml:(ONOXMLElement *)xml;
@end
