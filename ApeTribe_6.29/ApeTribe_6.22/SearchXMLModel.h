//
//  SearchXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchXMLModel : NSObject

@property(nonatomic,assign)long softid;//软件id
@property(nonatomic,copy)NSString *author;//用户
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *name;//标题
@property(nonatomic,copy)NSString *url;//链接地址
@property(nonatomic,copy)NSString *pubDate;// 发布时间
@property(nonatomic,copy)NSString *type;//标题

- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
