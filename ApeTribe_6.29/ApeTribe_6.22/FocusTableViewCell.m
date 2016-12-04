//
//  FocusTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/7/2.
//  Copyright © 2016年 One. All rights reserved.
//

#import "FocusTableViewCell.h"

@implementation FocusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //
    self.portraitButton.layer.masksToBounds = YES;
    self.portraitButton.layer.cornerRadius = self.portraitButton.frame.size.height / 2.0;
    
}
- (void) setCell:(FriendXMLModel *)model
{
    self.model = model;
    [self.portraitButton sd_setBackgroundImageWithURL:URL(model.portrait)  forState:UIControlStateNormal placeholderImage:Image(@"headIcon_placeholder")];
    self.nameLb.text = model.name;
    self.detailLb.text = model.expertise;
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(56, self.frame.size.height - 0.5, IPHONE_W - 56, 0.5)];
    lineLb.backgroundColor = [UIColor colorWithWhite:0.887 alpha:1.000];
    [self.contentView addSubview:lineLb];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnAction:(UIButton *)sender {
    [self.delegate clickButtonAction:self.model.userId];
}
@end
