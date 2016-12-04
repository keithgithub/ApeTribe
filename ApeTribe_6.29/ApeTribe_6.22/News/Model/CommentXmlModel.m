//
//  CommentXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "CommentXmlModel.h"

@implementation CommentXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.commentId =[[[xml  firstChildWithTag:@"id"]numberValue] longValue];
        self.portrait = [[xml  firstChildWithTag:@"portrait"] stringValue];
        self.author =[[xml  firstChildWithTag:@"author"]stringValue];
        self.authorid =[[[xml firstChildWithTag:@"authorid"] numberValue] longValue];
        self.content=[[xml  firstChildWithTag:@"content"]stringValue];
        self.pubDate =[[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.appclient =[[[xml firstChildWithTag:@"appclient"] numberValue] longValue];
        
        
        NSArray *arr = [[xml firstChildWithTag:@"replies"] childrenWithTag:@"reply"];
        self.replies = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i = 0; i<arr.count; i++)
        {
            ONOXMLElement *element = arr[i];
            NSString *rauthor = [[element firstChildWithTag:@"rauthor"] stringValue];
            NSString *rpubDate = [[element firstChildWithTag:@"rpubDate"] stringValue];
            NSString *rcontent = [[element firstChildWithTag:@"rcontent"] stringValue];

            NSDictionary *dict = @{@"rauthor":rauthor,@"rpubDate":rpubDate,@"rcontent":rcontent};
            
            [self.replies addObject:dict];
        }
    }
    
    return self;
}


+ (instancetype) commmentXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}
@end
