//
//  BloggerDetailXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/29.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface BloggerDetailXmlModel : NSObject
@property(nonatomic,assign)long   bloggerId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *where;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,assign)long   commentCount;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,assign)long   authoruid;
@property(nonatomic,assign)long   documentType;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)long   favorite;

- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)bloggerDetailXmlModelWithXml:(ONOXMLElement *)xml;
@end
