//
//  SheetTableViewCell.m
//  QueenComing_5.19
//
//  Created by ibokan on 16/5/31.
//  Copyright © 2016年 One. All rights reserved.
//

#import "SheetTableViewCell.h"

@implementation SheetTableViewCell

- (void) setCell:(NSDictionary *)dic
{
    self.imgV.image = [UIImage imageNamed:dic[@"image"]];
    self.title.text = dic[@"title"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
