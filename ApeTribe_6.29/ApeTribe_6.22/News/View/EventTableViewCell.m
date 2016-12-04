//
//  EventTableViewCell.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/25.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "EventTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "EventXmlModel.h"
@implementation EventTableViewCell

- (void)awakeFromNib
{
    self.status.layer.borderWidth = 0.5;
    self.status.layer.borderColor = [UIColor greenColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setContentCell:(EventXmlModel*)event
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:event.cover] placeholderImage:[UIImage imageNamed:@"photo_im"]];
    
    self.title.text = event.title;
    self.startTime.text = event.startTime;
    if (event.actor_count == 0)
    {
        self.actor_count.hidden = YES;
    }
    else
    {
        self.actor_count.text = [NSString stringWithFormat:@"%ld人参加",event.actor_count];
    }
    //判断选择状态
    switch (event.status)
    {
        case 1:
            self.status.text = @"活动结束";
            break;
        case 2:
            self.status.text = @"正在报名";
            break;
        case 3:
            self.status.text = @"报名截止";
            break;
        default:
            break;
    }
    
    //判断选择状态
    switch (event.category)
    {
        case 0:
            self.category.hidden = YES;
        case 1:
            self.category.text = @"源创会";
            break;
        case 2:
            self.category.text = @"技术交流";
            break;
        case 3:
            self.category.text = @"其他";
            break;
        case 4:
            self.category.text = @"站外活动";
        default:
            break;
    }
}

@end
