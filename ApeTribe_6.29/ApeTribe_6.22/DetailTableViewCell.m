//
//  DetailTableViewCell.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+LabelHight.h"
#import "HelpClass.h"
#import "text.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation DetailTableViewCell

//设置内容
-(void)setCell:(TweetCommentXmlModel *)tweetCommentModel
{
    
    self.model = tweetCommentModel;
    //头像
    [self.imgVHead sd_setImageWithURL:[NSURL URLWithString:tweetCommentModel.portrait] placeholderImage:[UIImage imageNamed:@"headIcon_placeholder"]];
    self.imgVHead.layer.cornerRadius = 17.5;
    //昵称
    self.lblName.text = tweetCommentModel.author;
    self.lblName.textColor = COLOR_BG_D_GREEN;
    //评论
//    self.lblComment.text = tweetCommentModel.content;
    self.lblComment.attributedText = [text test:tweetCommentModel.content];
    //评论高度
    self.commentH = [self getCommentH];
    self.commentHLayout.constant = self.commentH;
    
    //发布时间
    self.lblPushTime.text = [HelpClass compareCurrentTime:tweetCommentModel.pubDate];
    //判断设备类型
    self.imgVDevice.hidden = NO;
    if (tweetCommentModel.appclient == 3)
    {
        self.lblDevice.text = @"Android";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(tweetCommentModel.appclient == 4)
    {
        self.lblDevice.text = @"iPhone";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(tweetCommentModel.appclient == 2)
    {
        self.lblDevice.text = @"手机";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(tweetCommentModel.appclient == 5)
    {
        self.lblDevice.text = @"Window Phone";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else
    {
        self.lblDevice.text = @"";
        self.imgVDevice.hidden = YES;//不是设备隐藏图标
    }
    
    //头像单击手势
    UITapGestureRecognizer * tapPerson = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCommentAction:)];
    [self.imgVHead addGestureRecognizer:tapPerson];
    
}


//计算评论区文本高度
-(CGFloat)getCommentH
{
    return [NSString calStrSize:self.lblComment.text andWidth:self.lblComment.frame.size.width andFontSize:15].height;
}


//单击头像响应
-(void)tapCommentAction:(UITapGestureRecognizer *)tapPerson
{
    [self.delegate clickButtonAction:self.model.authorID];
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
