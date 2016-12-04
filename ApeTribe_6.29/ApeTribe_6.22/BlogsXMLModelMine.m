//
//  BlogsXMLModelMine.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "BlogsXMLModelMine.h"

@implementation BlogsXMLModelMine

- (instancetype) initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        self.blogsCount = [[[xml firstChildWithTag:@"blogsCount"]numberValue]intValue];
        self.blogs = [NSMutableArray new];
        ONOXMLElement *blogsXMLElement = [xml firstChildWithTag:@"blogs"];
        NSArray *blogs = [blogsXMLElement childrenWithTag:@"blog"];
//        NSLog(@"xml ====== %@",xml);
//        NSLog(@"blogs == %@",blogsXMLElement);
        // 将博客模型存入数组
        for (ONOXMLElement *element in blogs) {
            BlogXMLModelMine *model = [[BlogXMLModelMine alloc]initWithXML:element];
            [self.blogs addObject:model];
            NSLog(@"author = %@\ntitle = %@\npubDate = %@",model.authorname,model.title,model.pubDate);
        }
    }
    return self;
}
@end
