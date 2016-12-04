//
//  AnswerTableViewCell.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "AnswerTableViewCell.h"
#import "AnswerXmlModel.h"
#import "HelpClass.h"
#import "UIImageView+WebCache.h"
@implementation AnswerTableViewCell

- (void)awakeFromNib {
    self.imgV.layer.cornerRadius = 20;
    self.imgV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setContentCell:(AnswerXmlModel*)answer
{

    [self.imgV sd_setImageWithURL:[NSURL URLWithString:answer.portrait] placeholderImage:[UIImage imageNamed:@"headIcon_placeholder"]];
    self.title.text = answer.title;
    
    self.viewCount.text = [NSString stringWithFormat:@"%ld",answer.viewCount];
    self.body.text = answer.body;
    self.authorname.text = answer.author;
    self.pubDate.text = [HelpClass compareCurrentTime:answer.pubDate];
    self.commentCount.text = [NSString stringWithFormat:@"%ld",answer.answerCount];
    
    CGSize size = [answer.author boundingRectWithSize:CGSizeMake(MAXFLOAT, 26) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    
    self.widthConstraint.constant = size.width+5;
    
}
@end
