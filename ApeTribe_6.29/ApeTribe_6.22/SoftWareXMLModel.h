//
//  SoftWareXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface SoftWareXMLModel : NSObject
@property(nonatomic,assign)long softid;//软件id
@property(nonatomic,assign)long authorid;//评论用户社区id
@property(nonatomic,copy)NSString *author;//评论用户
@property(nonatomic,copy)NSString *body;//内容
@property(nonatomic,copy)NSString *portrait;//图片链接地址
@property(nonatomic,copy)NSString *pubDate;// 发布时间
@property(nonatomic,assign)long appclient;//动弹来源客户端类型
@property(nonatomic,assign)long commentCount;//评论个数
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
