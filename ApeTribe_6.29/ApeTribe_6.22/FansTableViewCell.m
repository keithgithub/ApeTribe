//
//  FansTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FansTableViewCell.h"
#import "MsgXMLModelMine.h"
#import "ActiveXMLModel.h"
#import "HelpClass.h"
@implementation FansTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.portraitButton.layer.masksToBounds = YES;
    self.portraitButton.layer.cornerRadius = self.portraitButton.frame.size.height / 2.0;
    
}
- (void) setCell:(id)obj
{
    self.obj = obj;
    if ([obj isKindOfClass:[MsgXMLModelMine class]])
    {
        MsgXMLModelMine *model = obj;
        self.nameLb.text = model.sendername;
        self.timeLb.text = model.pubDate;
        self.detailLb.text = model.content;
        self.timeLb.text = [HelpClass compareCurrentTime:model.pubDate];
        [self.portraitButton sd_setBackgroundImageWithURL:URL(model.portrait) forState:UIControlStateNormal placeholderImage:Image(@"headIcon_placeholder")];
        self.msgCount.text = [NSString stringWithFormat:@"%d封私信",model.messageCount];
    }
    else
    {
        ActiveXMLModel *model = obj;
        self.nameLb.text = model.author;
        self.timeLb.text = [HelpClass compareCurrentTime:model.pubDate];
        self.detailLb.text = model.message;
        [self.portraitButton sd_setBackgroundImageWithURL:URL(model.portrait) forState:UIControlStateNormal placeholderImage:Image(@"headIcon_placeholder")];
        self.msgCount.text = @"";
    }
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(56, self.frame.size.height - 0.5, IPHONE_W - 56, 0.5)];
    lineLb.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self.contentView addSubview:lineLb];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnAction:(UIButton *)sender {
    
    if ([self.obj isKindOfClass:[MsgXMLModelMine class]])
    {
        MsgXMLModelMine *model = self.obj;
        [self.delegate clickButtonAction:model.senderid];
    }
    else
    {
        ActiveXMLModel *model = self.obj;
        [self.delegate clickButtonAction:model.authorid];
    }
    
}
@end
