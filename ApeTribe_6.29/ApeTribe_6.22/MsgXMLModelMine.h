//
//  MsgXMLModelMine.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/4.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgXMLModelMine : NSObject
@property (nonatomic, assign)long msgId;// 私信id
@property(nonatomic,copy) NSString *portrait;// 私信人头像
@property(nonatomic,assign) long friendid;// 接收人ID
@property(nonatomic,copy) NSString *friendname;// 接收人用户名
@property  (nonatomic, assign) long senderid;// 发送者ID
@property (nonatomic, copy) NSString *sendername;// 发送者用户名
@property (nonatomic, copy) NSString *content;// 私信内容
@property (nonatomic, assign) int messageCount;// 来往私信数
@property (nonatomic, copy) NSString *pubDate;// 私信发送日期

- (instancetype)initWithXML:(ONOXMLElement *)xml;

@end
