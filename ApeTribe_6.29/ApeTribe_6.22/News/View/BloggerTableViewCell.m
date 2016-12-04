//
//  BloggerTableViewCell.m
//  OpenSourceChina
//
//  Created by bokan on 16/6/24.
//  Copyright © 2016年 guozhidong. All rights reserved.
//

#import "BloggerTableViewCell.h"
#import "BloggerXmlModel.h"
#import "HelpClass.h"
@implementation BloggerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setContentCell:(BloggerXmlModel*)blogger andStyle:(int)style
{
    if (style == 0)
    {
        NSString *title = [NSString stringWithFormat:@"             %@",blogger.title];
        self.img1.image = [UIImage imageNamed:@"recommend_tag.png"];
        self.img2.image = [UIImage imageNamed:@"widget-original@3x"];
        self.title.text = title;
    }
    else
    {
        NSString *title = [NSString stringWithFormat:@"      %@",blogger.title];
        self.img1.image = [UIImage imageNamed:@"widget-original@3x"];
        self.img2.image = nil;
        self.title.text = title;
    }
    
    self.body.text = blogger.body;
    self.authorname.text = blogger.authorname;
    self.pubDate.text = [HelpClass compareCurrentTime:blogger.pubDate];
    self.commentCount.text = [NSString stringWithFormat:@"%ld",blogger.commentCount];
    
    CGSize size = [blogger.authorname boundingRectWithSize:CGSizeMake(MAXFLOAT, 26) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    
    self.widthConstraint.constant = size.width+5;
    
}

@end
