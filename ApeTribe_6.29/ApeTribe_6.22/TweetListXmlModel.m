//
//  TweetListXmlModel.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "TweetListXmlModel.h"

@implementation TweetListXmlModel


-(instancetype)initWithXML:(ONOXMLElement *)xml
{
    if (self = [super init])
    {
        //动弹ID
        self.tweetListId = [[[xml firstChildWithTag:@"id"]numberValue]intValue];
        //动弹时间
        self.pubData = [[xml firstChildWithTag:@"pubDate"]stringValue];
        //动弹内容
        self.body = [[xml firstChildWithTag:@"body"]stringValue];
        //发布人
        self.author = [[xml firstChildWithTag:@"author"]stringValue];
        //发布人ID
        self.authorId = [[[xml firstChildWithTag:@"authorid"]numberValue]longValue];
        //评论数
        self.commentCount = [[[xml firstChildWithTag:@"commentCount"]numberValue]intValue];
        //用户头像地址
        self.portrait = [[xml firstChildWithTag:@"portrait"]stringValue];
        //设备
        self.appClient = [[[xml firstChildWithTag:@"appclient"]numberValue]intValue];
        //点赞数量
        self.likeCount = [[[xml firstChildWithTag:@"likeCount"]numberValue]intValue];
        //缩略图地址
        self.imgSmall = [[xml firstChildWithTag:@"imgSmall"]stringValue];
        //图片详情地址
        self.imgBig = [[xml firstChildWithTag:@"imgBig"]stringValue];
        
        //点赞列表
        NSArray *arr = [[xml firstChildWithTag:@"likeList"] childrenWithTag:@"user"];
        self.likeList = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i = 0; i<arr.count; i++)
        {
            ONOXMLElement *element = arr[i];
            NSString *name = [[element firstChildWithTag:@"name"] stringValue];
            NSString *uid = [[element firstChildWithTag:@"uid"] stringValue];
            NSString *portrait = [[element firstChildWithTag:@"portrait"] stringValue];
            
            NSDictionary *dict = @{@"name":name,@"uid":uid,@"portrait":portrait};
            
            [self.likeList addObject:dict];
        }
    }
    return self;
}


+(instancetype)tweetListXmlModelWithXml:(ONOXMLElement *)xml
{
    return [[self alloc]initWithXML:xml];
}








@end
