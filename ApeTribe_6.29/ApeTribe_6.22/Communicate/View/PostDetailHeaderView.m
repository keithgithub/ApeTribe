//
//  PostDetailHeaderView.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/28.
//  Copyright © 2016年 One. All rights reserved.
//

#import "PostDetailHeaderView.h"
#import "PostDetailXmlModel.h"
#import "HelpClass.h"
#import "NSString+FontSize.h"
#import "MessageDetailModel.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation PostDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setPostDetailContentView:(PostDetailXmlModel*)postDetail
{
    self.title.text = [NSString stringWithFormat:@"%@",postDetail.title];
    
    self.author.text = postDetail.author;
    NSString *pubData1 = [HelpClass compareCurrentTime:postDetail.pubDate];
    self.pubDate.text = [NSString stringWithFormat:@"发表于  %@",pubData1];
    
    //计算宽度
    self.width.constant = [postDetail.author boundingRectWithSize:CGSizeMake(MAXFLOAT, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size.width+10;
    
    self.lbl.text = @"相关文章:";
    
    if (postDetail.tags.count == 0)
    {
        self.tagPost.hidden = NO;
    }
    else
    {
        self.tagPost.hidden = YES;
        
    }
    
}

-(void)setMessageDetailContentView:(MessageDetailModel*)messageDetail
{
    self.title.text = [NSString stringWithFormat:@"%@",messageDetail.title];
    
    self.author.text = messageDetail.author;
    NSString *pubData1 = [HelpClass compareCurrentTime:messageDetail.pubDate];
    self.pubDate.text = [NSString stringWithFormat:@"发表于  %@",pubData1];
    
    //计算宽度
    self.width.constant = [messageDetail.author boundingRectWithSize:CGSizeMake(MAXFLOAT, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size.width+10;
    
}

@end
