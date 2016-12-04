//
//  PostDetailXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "PostDetailXmlModel.h"

@implementation PostDetailXmlModel
-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self =[super init])
    {
        self.postId =[[[xml  firstChildWithTag:@"id"]numberValue] longValue];
        self.title = [[xml  firstChildWithTag:@"title"] stringValue];
        self.url = [[xml  firstChildWithTag:@"url"] stringValue];
        self.event = [[xml  firstChildWithTag:@"event"] stringValue];
        self.body =[[xml  firstChildWithTag:@"body"]stringValue];
        self.answerCount =[[[xml firstChildWithTag:@"answerCount"] numberValue] longValue];
        self.author=[[xml  firstChildWithTag:@"author"]stringValue];
        self.authorid =[[[xml  firstChildWithTag:@"authorid"]numberValue ] longValue];
        self.pubDate =[[xml  firstChildWithTag:@"pubDate"] stringValue];
        self.viewCount =[[[xml firstChildWithTag:@"viewCount"] numberValue] longValue];
        self.portrait = [[xml firstChildWithTag:@"portrait"] stringValue];
        self.favorite =[[[xml firstChildWithTag:@"favorite"] numberValue] longValue];
        NSLog(@"%@",xml);
        
        NSArray * arr = [[xml firstChildWithTag:@"tags"] childrenWithTag:@"tag"];
//        NSLog(@"%@",arr);
//        self.tags = [NSMutableArray arrayWithCapacity:arr.count];
//        for (ONOXMLElement *obj in arr)
//        {
//            NSString *str = [[obj firstChildWithTag:@"tag"] stringValue];
//            [self.tags addObject:str];
//        }
        
        self.tags = [NSMutableArray  new];
        for (int i=0; i<arr.count; i++)
        {
            ONOXMLElement *tage = arr[i];
            [self.tags addObject:[tage stringValue]];
            
        }
        
        //        ONOXMLElement *tagsss= [xml  firstChildWithTag:@"tags"];
//        ONOXMLElement *tag1111 = [tagsss firstChildWithTag:@"tag"];
//        NSLog(@"%@",[tag1111 stringValue]);
        
    }
    return self;
}


+ (instancetype)postXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}
@end
