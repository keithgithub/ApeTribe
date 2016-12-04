//
//  TweetDetailXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TweetDetailXmlModel.h"

@implementation TweetDetailXmlModel

-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        //漫谈的ID
        self.tweetDetailID = [[[xml firstChildWithTag:@"id"]numberValue]intValue];
        //漫谈作者的头像地址
        self.portrait = [[xml firstChildWithTag:@"portrait"]stringValue];
        //漫谈的作者昵称
        self.author = [[xml firstChildWithTag:@"author"]stringValue];
        //漫谈作者的社区ID
        self.authorID = [[[xml firstChildWithTag:@"authorid"]numberValue]longValue];
        //漫谈的内容
        self.body = [[xml firstChildWithTag:@"body"]stringValue];
        //语音漫谈的地址
        self.attach = [[xml firstChildWithTag:@"attach"]stringValue];
        //漫谈来源客户端类型
        self.appclient = [[[xml firstChildWithTag:@"appclient"]numberValue]intValue];
        //漫谈评论数量
        self.commentCount = [[[xml firstChildWithTag:@"commentCount"]numberValue]intValue];
        //漫谈发布日期
        self.pubDate = [[xml firstChildWithTag:@"pubDate"]stringValue];
        //漫谈图片缩略图地址
        self.imgSmall = [[xml firstChildWithTag:@"imgSmall"]stringValue];
        //漫谈图片地址
        self.imgBig = [[xml firstChildWithTag:@"imgBig"]stringValue];
        //漫谈的点赞数量
        self.likeCount = [[[xml firstChildWithTag:@"likeCount"]numberValue]intValue];
        //是否已经对该漫谈点赞
        self.isLike = [[[xml firstChildWithTag:@"isLike"]numberValue]intValue];
        
        //点赞列表
        NSArray *arr = [[xml firstChildWithTag:@"likeList"]childrenWithTag:@"user"];
        self.likeList = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i = 0; i<arr.count; i++)
        {
            ONOXMLElement *element = arr[i];
            NSString * name = [[element firstChildWithTag:@"name"] stringValue];
            NSString * uid = [[element firstChildWithTag:@"uid"] stringValue];
            NSString * portrait = [[element firstChildWithTag:@"portrait"] stringValue];
            
            NSDictionary * dic = @{@"name":name,@"uid":uid,@"portrait":portrait};
            
            [self.likeList addObject:dic];
        }

    }
    return self;
}


+(instancetype)tweetDetailXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}






@end
