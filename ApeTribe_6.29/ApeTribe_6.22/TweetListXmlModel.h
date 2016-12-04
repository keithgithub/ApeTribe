//
//  TweetListXmlModel.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface TweetListXmlModel : NSObject

//动弹ID
@property(nonatomic,assign)int tweetListId;
//动弹时间
@property(nonatomic,copy)NSString * pubData;
//动弹内容
@property(nonatomic,copy)NSString * body;
//发帖人
@property(nonatomic,copy)NSString * author;
//发帖人ID
@property(nonatomic,assign)long authorId;
//评论数
@property(nonatomic,assign)int commentCount;
//发帖人头像地址
@property(nonatomic,copy)NSString * portrait;
//设备
@property(nonatomic,assign)int appClient;
//语音地址
@property(nonatomic,copy)NSString * attach;
//图片缩略图地址
@property(nonatomic,copy)NSString * imgSmall;
//图片地址
@property(nonatomic,copy)NSString * imgBig;
//点赞数量
@property(nonatomic,assign)int likeCount;
//点赞列表
@property(nonatomic,strong)NSMutableArray * likeList;



-(instancetype)initWithXML:(ONOXMLElement *)xml;

+(instancetype)tweetListXmlModelWithXml:(ONOXMLElement *)xml;


@end
