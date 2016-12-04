//
//  MessageTableViewCell.m
//  OpenSourceChina
//
//  Created by ibokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageXmlModel.h"
#import "HelpClass.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setContentCell:(MessageXmlModel*)message
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:message.pubDate];
    NSString *today = [HelpClass compareDate:timeDate];
    if ([today isEqualToString:@"今天"])
    {
        self.imgV.hidden = NO;
        NSString *title = [NSString stringWithFormat:@"     %@",message.title];
        self.title.text = title;
        self.imgV.image = [UIImage imageNamed:@"jintian"];
        
    }
    else
    {
        self.imgV.hidden = YES;
        self.title.text = message.title;
    }
    
    self.body.text = message.body;
    self.commentCount.text = [NSString stringWithFormat:@"%ld",message.commentCount];
    self.pubDate.text = [HelpClass compareCurrentTime:message.pubDate];

}

@end
