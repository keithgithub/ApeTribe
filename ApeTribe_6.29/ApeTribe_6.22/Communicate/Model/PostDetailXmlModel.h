//
//  PostDetailXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface PostDetailXmlModel : NSObject
@property(nonatomic,assign)long   postId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *event;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,assign)long   authorid;
@property(nonatomic,assign)long   answerCount;
@property(nonatomic,assign)long   viewCount;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,assign)long   favorite;

@property(nonatomic,strong) NSMutableArray *tags;



- (instancetype)initWithXML:(ONOXMLElement *)xml;
+ (instancetype)postXmlModelWithXml:(ONOXMLElement *)xml;
@end
