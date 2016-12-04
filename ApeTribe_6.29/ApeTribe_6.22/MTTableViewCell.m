//
//  MTTableViewCell.m
//  6.23.OSChina
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import "MTTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HelpClass.h"
#import "NSString+LabelHight.h"
#import "UUImageAvatarBrowser.h"
#import "MineViewController.h"
#import "text.h"


#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation MTTableViewCell


//设置内容
-(void)setCell:(TweetListXmlModel *)tweetListModel
{

    
    //头像
    [self.imgVHead sd_setImageWithURL:[NSURL URLWithString:tweetListModel.portrait] placeholderImage:[UIImage imageNamed:@"headIcon_placeholder"]];
    self.imgVHead.layer.cornerRadius = 17.5;
    
    //昵称
    self.lblName.text = tweetListModel.author;
    self.lblName.textColor = COLOR_BG_D_GREEN;
    //发布时间
    self.lblPushTime.text = [HelpClass compareCurrentTime:tweetListModel.pubData];
    
    
    
    //设备
    //显示图标
    self.imgVDevice.hidden = NO;
    //判断设备类型
    if (tweetListModel.appClient == 3)
    {
        self.lblDevice.text = @"Android";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(tweetListModel.appClient == 4)
    {
        self.lblDevice.text = @"iPhone";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(tweetListModel.appClient == 2)
    {
        self.lblDevice.text = @"手机";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else if(tweetListModel.appClient == 5)
    {
        self.lblDevice.text = @"Window Phone";
        self.imgVDevice.image = [UIImage imageNamed:@"iphone"];
    }
    else
    {
        self.lblDevice.text = @"";
        self.imgVDevice.hidden = YES;//不是设备隐藏图标
    }
    
    //内容
//    self.lblContent.text = tweetListModel.body;
    self.lblContent.attributedText = [text test:tweetListModel.body];

    
    //评论数
    self.lblCommentCount.text = [NSString stringWithFormat:@"%d",tweetListModel.commentCount];
    
    //点赞数量
    self.lblLikeCount.text = [NSString stringWithFormat:@"%d",tweetListModel.likeCount];
    
    //点赞按钮
    [self.btnLike setImage:[UIImage imageNamed:@"ic_thumbup_normal"] forState:UIControlStateNormal];
    [self.btnLike setTintColor:[UIColor grayColor]];
    
    
    //缩略图
    [self.imgVSmall sd_setImageWithURL:[NSURL URLWithString:tweetListModel.imgSmall]];

    //定义calW与calH存放图片的宽高
    CGFloat calW = self.imgVSmall.image.size.width;
    CGFloat calH = self.imgVSmall.image.size.height;
    //计算文本高度
    CGFloat h = [self getContentH]+20;
    
    //判断是否有图片
    if ([tweetListModel.imgSmall isEqualToString:@""])//无图
    {
        self.imgHLayout.constant = 0;//高
        self.imgWLayout.constant = 0;//宽
        self.contentHLayout.constant = h;
        //无图只有内容区高度
        self.tempH = self.contentHLayout.constant;
    }
    else
    {
        self.imgHLayout.constant = calH;//高
        self.imgWLayout.constant = calW;//宽
//        if (self.imgWLayout.constant >= self.frame.size.width-30)
//        {
//            self.imgWLayout.constant = self.frame.size.width-30;
//        }
        self.contentHLayout.constant = h;
        //图片与内容区高度
        self.tempH = self.contentHLayout.constant + self.imgHLayout.constant;
        
    
        //点击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        //添加手势
        [self.imgVSmall addGestureRecognizer:tap];
        //原始图片
        self.imgVBig = [UIImageView new];
        [self.imgVBig sd_setImageWithURL:[NSURL URLWithString:tweetListModel.imgBig]];
    }
    
    

    
}

//内容区高度
-(CGFloat)getContentH
{
    return [NSString calStrSize:self.lblContent.text andWidth:self.lblContent.frame.size.width andFontSize:14].height;
}

//手势响应
-(void)tapAction:(UITapGestureRecognizer *)sender
{
    //调用
    [UUImageAvatarBrowser showImage:self.imgVBig];
}






//- (void)awakeFromNib
//{
//   
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
