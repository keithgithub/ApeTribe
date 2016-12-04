//
//  BlogsXMLModelMine.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BlogXMLModelMine.h"

@interface BlogsXMLModelMine : NSObject

@property (nonatomic, assign)int blogsCount;// 博客总数
@property (nonatomic, strong) NSMutableArray<BlogXMLModelMine *> *blogs;
- (instancetype)initWithXML:(ONOXMLElement *)xml;
@end
