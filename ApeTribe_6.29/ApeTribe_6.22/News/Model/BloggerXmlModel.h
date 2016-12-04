//
//  BloggerXmlModel.h
//  OpenSourceChina
//
//  Created by bokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface BloggerXmlModel : NSObject
@property(nonatomic,assign)long   bloggerId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,assign)long   commentCount;
@property(nonatomic,copy)NSString *authorname;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,assign)long   authoruid;
@property(nonatomic,assign)long   documentType;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int type;//0 - 最热   1 - 最新

- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)bloggerXmlModelWithXml:(ONOXMLElement *)xml;
@end
