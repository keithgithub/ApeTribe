//
//  MTTableViewCell.h
//  6.23.OSChina
//
//  Created by ibokan on 16/6/23.
//  Copyright © 2016年 Ldm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetListXmlModel.h"

@interface MTTableViewCell : UITableViewCell


//头像
@property (weak, nonatomic) IBOutlet UIImageView *imgVHead;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *lblName;
//发布时间图标
@property (weak, nonatomic) IBOutlet UIImageView *imgVPushTime;
//发布时间
@property (weak, nonatomic) IBOutlet UILabel *lblPushTime;
//设备图标
@property (weak, nonatomic) IBOutlet UIImageView *imgVDevice;
//设备
@property (weak, nonatomic) IBOutlet UILabel *lblDevice;
//内容
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
//点赞个数
@property (weak, nonatomic) IBOutlet UILabel *lblLikeCount;
//评论图标
@property (weak, nonatomic) IBOutlet UIImageView *imgVComment;
//评论个数
@property (weak, nonatomic) IBOutlet UILabel *lblCommentCount;
//点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
//缩略图
@property (weak, nonatomic) IBOutlet UIImageView *imgVSmall;
//分割线
@property (weak, nonatomic) IBOutlet UILabel *lblCutLines;
//原图
@property(nonatomic,strong)UIImageView * imgVBig;


//内容区高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHLayout;

//图片高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHLayout;
//图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWLayout;

//内容与图片高度
@property(nonatomic,assign)CGFloat tempH;



//设置内容方法
-(void)setCell:(TweetListXmlModel *)tweetListModel;

//设置内容区高度
-(CGFloat)getContentH;



@end
