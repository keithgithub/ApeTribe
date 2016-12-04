//
//  ZanTableViewCell.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/27.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "ZanTableViewCell.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation ZanTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //选中状态
        self.selectionStyle = NO;
        
        //头像
        self.imgVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        self.imgVHead.layer.cornerRadius = 15;

        
        //昵称
        self.lblName = [[UILabel alloc]initWithFrame:CGRectMake(20+self.imgVHead.frame.size.width, self.imgVHead.frame.size.height/2, 200, 20)];
        //字体大小
        self.lblName.font = [UIFont systemFontOfSize:14];
        
        
        //分割线
        self.lblCutLines = [[UILabel alloc]initWithFrame:CGRectMake(10, 20+self.imgVHead.frame.size.height, SCREEN_SIZE.width-10, 1)];
        //颜色
        self.lblCutLines.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        //显示
        [self.contentView addSubview:self.imgVHead];
        [self.contentView addSubview:self.lblName];
        [self.contentView addSubview:self.lblCutLines];
    }
    return  self;
}


//设置内容
-(void)setCell:(TweetLikeListXmlModel *)tweetLikeList
{
    //头像
    [self.imgVHead sd_setImageWithURL:[NSURL URLWithString:tweetLikeList.portrait] placeholderImage:[UIImage imageNamed:@"headIcon_placeholder"]];
    //昵称
    self.lblName.text = tweetLikeList.name;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
