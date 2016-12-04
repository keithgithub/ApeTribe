//
//  BlogMineTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/5.
//  Copyright © 2016年 One. All rights reserved.
//

#import "BlogMineTableViewCell.h"
#import "HelpClass.h"
@implementation BlogMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setCell:(id)obj
{
    BlogXMLModelMine *model = obj;
    switch (model.type) {
        case 1:// 原创
            self.typeImgV.image = Image(@"widget-original");
            break;
        case 4:// 转载
            self.typeImgV.image = Image(@"widget_repost");
            break;
        default:
            break;
    }
    self.titleLb.text = model.title;
    self.timeLb.text = [HelpClass compareCurrentTime:model.pubDate];
    self.commentCountLb.text = [NSString stringWithFormat:@"%d",model.commentCount];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
