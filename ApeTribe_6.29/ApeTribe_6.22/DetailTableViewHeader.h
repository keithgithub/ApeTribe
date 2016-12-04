//
//  DetailTableViewHeader.h
//  ApeTribe_6.22
//
//  Created by ibokan on 16/6/30.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetDetailXmlModel.h"
#import "DetailViewController.h"

typedef void(^ClickPortrait)(long userId);
typedef void(^btnZanBlock)(int zan);

@interface DetailTableViewHeader : UIView

@property(nonatomic,strong)DetailViewController * detailVC;

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
//点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
//内容
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imgVSmall;
//点赞列表
@property (weak, nonatomic) IBOutlet UILabel *lblLikeList;

@property(nonatomic,strong)UIImageView * imgVBig;

//内容区高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHLayout;
//点赞列表高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likeListHLayout;
//图片视图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHLayout;
//图片视图宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWLayout;

//图片与文本框高度
@property(nonatomic,assign)CGFloat tempH;


@property(nonatomic,assign)TweetDetailXmlModel * detailModel;


@property(nonatomic,strong)btnZanBlock btnZanHandle;
@property (copy) ClickPortrait portraitHandle;
//获取内容区高度
-(CGFloat)getContentH;
//获取点赞列表高度
-(CGFloat)getLikeListH;


//设置内容方法
-(void)setHeader:(TweetDetailXmlModel *)model;


@end
