//
//  DetailTableViewCell.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/26.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "DetailTableViewCell.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation DetailTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //选中状态
        self.selectionStyle = NO;
        
        
        //头像
        self.imgVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
        self.imgVHead.layer.cornerRadius = 17.5;
        
        //昵称
        self.lblName = [[UILabel alloc]initWithFrame:CGRectMake(10+self.imgVHead.frame.size.width+10, self.imgVHead.frame.origin.y, SCREEN_SIZE.width-30-self.imgVHead.frame.size.width, 15)];
        //字体大小
        self.lblName.font = [UIFont systemFontOfSize:14];
        
        
        //发布时间
        self.btnPushTime = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btnPushTime.frame = CGRectMake(self.lblName.frame.origin.x, 10+5+self.lblName.frame.size.height, 75, 15);
        //字体大小
        self.btnPushTime.titleLabel.font = [UIFont systemFontOfSize:12];
        //字体颜色
        [self.btnPushTime setTintColor:[UIColor grayColor]];
        //图片边距
        [self.btnPushTime setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        //标题边距
        [self.btnPushTime setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        
        
        //设备
        self.btnDevices = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btnDevices.frame = CGRectMake(self.btnPushTime.frame.origin.x+self.btnPushTime.frame.size.width, self.btnPushTime.frame.origin.y, 75, 15);
        //字体大小
        self.btnDevices.titleLabel.font = [UIFont systemFontOfSize:12];
        //字体颜色
        [self.btnDevices setTintColor:[UIColor grayColor]];
        //图片边距
        [self.btnDevices setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        //标题边距
        [self.btnDevices setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        
        
        //评论
        self.lblComment = [[UILabel alloc]initWithFrame:CGRectMake(self.lblName.frame.origin.x, 10+self.imgVHead.frame.origin.x+self.imgVHead.frame.size.height, SCREEN_SIZE.width-30-self.imgVHead.frame.size.width, 15)];
        //字体大小
        self.lblComment.font = [UIFont systemFontOfSize:14];
        self.lblComment.numberOfLines = 0;
        
        
        //分割线
        self.lblCutLines = [[UILabel alloc]initWithFrame:CGRectMake(10, self.lblComment.frame.origin.y+self.lblComment.frame.size.height+10, SCREEN_SIZE.width-10, 1)];
        //颜色
        self.lblCutLines.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        
        
        //显示
        [self.contentView addSubview:self.imgVHead];
        [self.contentView addSubview:self.lblName];
        [self.contentView addSubview:self.lblComment];
        [self.contentView addSubview:self.btnPushTime];
        [self.contentView addSubview:self.btnDevices];
        [self.contentView addSubview:self.lblCutLines];
    }
    return self;
}


//设置内容
-(void)setCell:(NSDictionary *)dic
{
    //头像
    self.imgVHead.image = [UIImage imageNamed:dic[@"image"]];
    //昵称
    self.lblName.text = dic[@"name"];
    //内容
    self.lblComment.text = dic[@"comment"];
    //发布时间
    [self.btnPushTime setImage:[UIImage imageNamed:@"time"] forState:UIControlStateNormal];
    [self.btnPushTime setTitle:@"40分钟前" forState:UIControlStateNormal];
    //设备
    [self.btnDevices setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self.btnDevices setTitle:@"iPhone 6" forState:UIControlStateNormal];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
