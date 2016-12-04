//
//  CommentTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/1.
//  Copyright © 2016年 One. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentXmlModel.h"
#import "UIImageView+WebCache.h"
#import "HelpClass.h"
#import "text.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation CommentTableViewCell

- (void)awakeFromNib {
    self.imgV.layer.cornerRadius = 20;
    self.imgV.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCell:(CommentXmlModel*)commentModel
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:commentModel.portrait] placeholderImage:[UIImage imageNamed:@"headIcon_placeholder"]];
    self.author.text = commentModel.author;
    self.pubDate.text = [HelpClass compareCurrentTime:commentModel.pubDate];

    if (commentModel.content == nil)
    {
        self.contentHeight.constant = 0;
        self.content.hidden = YES;
    }
    else
    {
        while ([commentModel.content hasSuffix:@" "])
        {
            [commentModel.content substringToIndex:commentModel.content.length-1];
        }
        self.contentHeight.constant = [commentModel.content boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    }
//    
//    if (commentModel.refers.count<=0)
//    {
//        self.referHeight.constant = 0;
//        self.referView.hidden = YES;
//    }
//    else
//    {
//        self.referHeight.constant = [commentModel.content boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
//    }
    
    self.content.attributedText = [text test:commentModel.content];
    
    if (commentModel.replies.count == 0)
    {
        self.replyHeight.constant = 0;
        self.replies.hidden = YES;
    }
    else
    {
        NSMutableString *string = [NSMutableString stringWithFormat:@"--共有%ld条评论--\n",commentModel.replies.count];
        for (int i= 0; i<commentModel.replies.count; i++)
        {
            NSDictionary *dict = commentModel.replies[i];
            [string appendString:[NSString stringWithFormat:@"%@:%@\n",dict[@"rauthor"],dict[@"rcontent"]]];
        }
        
        NSString *reply = [string substringToIndex:string.length-1];
        
        self.replyHeight.constant = [reply boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width-64, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height+10;
        self.replies.text = reply;
    }
    
}
@end
