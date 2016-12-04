//
//  LeftTableViewCell.m
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 One. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6.5, 30, 30)];
        [self.contentView addSubview:self.imgV];
        
        self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, IPHONE_W, 21)];
        self.titleLb.center = CGPointMake(self.titleLb.center.x, self.imgV.center.y);
        self.titleLb.font = FONT(12.5);
        self.titleLb.textColor = COLOR_FONT_D_GRAY;
        [self.contentView addSubview:self.titleLb];
        
        self.lineLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 43.5, IPHONE_W - 44, 0.5)];
        self.lineLb.backgroundColor = COLOR_BG_D_GRAY;
        [self.contentView addSubview:self.lineLb];
        
    }
    return self;
}

- (void) setCell:(NSDictionary *)dic
{
    self.imgV.image = Image(dic[@"image"]);
    self.titleLb.text = dic[@"title"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
