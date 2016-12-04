//
//  BlogXMLModelMine.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/4.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogXMLModelMine : NSObject

@property(nonatomic, assign) long blogId;// 博客id
@property(nonatomic,copy) NSString *authorname;// 投递者名称
@property (nonatomic, copy) NSString *title;// 博客标题
@property (nonatomic, copy) NSString *pubDate;// 发布时间
@property(nonatomic,assign) long authorid;// 投递者标号
@property  (nonatomic, assign) int commentCount;// 评论数
@property (nonatomic, assign) long type;// 1-原创 4-转载

- (instancetype)initWithXML:(ONOXMLElement *)xml;

@end
