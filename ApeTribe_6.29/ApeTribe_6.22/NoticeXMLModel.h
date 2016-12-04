//
//  NoticeXMLModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"
@interface NoticeXMLModel : NSObject
@property (nonatomic, assign) int atmeCount;// @我的数量
@property (nonatomic, assign) int msgCount;// 私信的数量
@property (nonatomic, assign) int reviewCount;// 新的评论数量
@property (nonatomic, assign) int newFansCount;// 新粉丝的数量
@property (nonatomic, assign) int newLikeCount;// 新点赞的数量
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
